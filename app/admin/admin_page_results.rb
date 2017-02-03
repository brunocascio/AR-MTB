ActiveAdmin.register_page "Add Results" do
  menu label: I18n.t("activerecord.models.result.other")

  content only: :index, title: I18n.t("activerecord.models.result.other") do
    render 'index'
  end

  page_action :store, method: [:post] do
    head :error unless request.post?
  end

  controller do
    before_action :validate, only: [:store]

    def index
    end

    def store
     begin
      results = params[:results].map { |obj| Result.new(obj.to_hash) }
      results = Result.sync(results)
     rescue => e
       logger.error e
       render status: 500, json: { message: e.message }
     else
       render json: results.to_json
     end
    end

    private

    def validate
      params.require :results
      params.permit results: [
        :participant_id,
        :participant_number,
        :time,
        :absent,
        :finished,
        :race_id
      ]
    end
  end
end
