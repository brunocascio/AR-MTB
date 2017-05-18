class ResultsController < ApplicationController

  before_action :validate

  # GET /results
  #
  # TODO:
  #   => Improve this ineficient method!
  #   => Refactoring (scopes, SoC)
  #
  def index

    # championship schedules
    @schedules = Schedule.current_championship.finishes

    # filter by schedule nummber if param is present
    if (params[:schedule].presence)
      @schedule = @schedules.find_by!(number: params[:schedule])
    else
      # last schedule by default
      @schedule = @schedules.last
    end

    # Make results hash to return
    @results = {f: {}, m: {}}
    Category.all.each do |cat|
      @results[:m][cat.name] = {}
      @results[:f][cat.name] = {}
      Subcategory.with_category(cat.id).each do |subcat|
        @results[subcat.genre.to_sym][cat.name][subcat.name] = {}
      end
    end

    unless @schedule.nil?
      # Results query
      # Is not sql-injectable
      results_query = Result.connection
        .select_all("
          SELECT
            position, finished, absent, participant_number,
            IF(subcat.genre = 1, 'm', 'f') as genre,
            CONCAT(p.firstname, ' ', p.lastname) as participant,
            DATE_FORMAT(time, '%h:%i:%s') as time,
            cat.name as category,
            subcat.name as subcategory
          FROM results res
            INNER JOIN participants p on p.id = res.participant_id
            INNER JOIN locations l on l.id = p.location_id
            INNER JOIN categories cat on cat.id = res.category_id
            INNER JOIN subcategories subcat on subcat.id = res.subcategory_id
            INNER JOIN races r on r.id = res.race_id
            INNER JOIN schedules s on s.id = r.schedule_id
            INNER JOIN championships c on c.id = s.championship_id
          WHERE
            s.number = #{@schedule.number}
          AND
            c.year = #{@schedule.championship.year}
          ORDER BY position
        ")
    else
      results_query = []
    end

    # Add query results to hash
    @results.keys.each do |genre|
      genres = @results[genre]
      genres.keys.each do |cat|
        subcategories = genres[cat]
        subcategories.keys.each do |subcat|
          subcategories[subcat] = results_query.select do |r|
            (r['category'] == cat.to_s) &&
            (r['subcategory'] == subcat.to_s) &&
            (r['genre'] == genre.to_s)
          end
          # subcategories[subcat] = subcategories[subcat].select{|c| c[:position].nil?} + subcategories[subcat].reject{|c| c[:position].nil?}
          subcategories[subcat] = sort(subcategories[subcat])
          subcategories.delete(subcat) if subcategories[subcat].empty?
          genres.delete(cat) if genres[cat].empty?
        end
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def validate
      params.permit :schedule
    end

    def sort(r)
      r.reject {|e| e['position'].nil?} + r.select {|e| e['position'].nil?}
    end
end
