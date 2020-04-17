module App
  class Api
    module Controllers

      get '/projects/:project_id/installations' do
        @project.installations.to_json
      end

      post '/projects/:project_id/installations' do
        content_type :text
        @project.installations.create(params[:installation])
      end

    end
  end
end
