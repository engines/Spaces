module App
  class Api
    module Controllers

      before '/projects/:project_id/?*' do
        set_project
      end

      get '/projects' do
        Spaces.projects.to_json
      end

      post '/projects' do
        content_type :text
        Spaces.projects.create(params[:project])
      end

      get '/projects/:project_id' do
        @project.to_json
      end

      delete '/projects/:project_id' do
        @project.delete
        'true'
      end

      helpers do
        def set_project
          @project = Spaces.projects.by(params[:project_id])
        end
      end

    end
  end
end
