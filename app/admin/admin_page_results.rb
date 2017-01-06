ActiveAdmin.register_page "Add Results" do
  menu label: I18n.t("activerecord.models.result.other")

  content only: :index, title: I18n.t("activerecord.models.result.other") do
    render 'index'
  end

  page_action :store, method: [:post] do
    head :error unless request.post?
  end

  controller do
     def index
     end
     def store
       results = []
       begin
         results = ResultHelper.parse_results!(params[:_json])
         results = Result.sync(results)
       rescue => e
         raise e
         logger.error e.message
         render json: {message: e.message}
       else
         render json: results
       end
     end
  end
end
