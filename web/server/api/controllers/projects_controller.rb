module Server
  class Api
    module Controllers

      # require "./ruby/installations/installation"

      # post '/projects/:project_id/installations' do
      #   content_type :text
      #   set_project
      #   @project.install params[:identifier]
      #   installation = Installations::Installation.new blueprint: project, descriptor: descriptor_for(params[:identifier])
      #   universe.installations.save(installation)
      #   installation.identifier
      # end

      get '/projects' do
        Spaces.projects.to_json
      end

      get '/projects/:project_id' do
        Spaces.projects.find(params[:project_id]).to_json
      end

      get '/projects/:project_id/installations' do
        Spaces.projects.find(params[:project_id]).installations.to_json
        # universe.installations.descriptors.select do |d|
        #   d.identifier == project.identifier
        # end.to_json
      end


      # get '/:resources_name' do
      #   universe.send(params[:resources_name]).identifiers.to_json
      # end
      #
      # get '/:resources_name/:id' do
      #   content_type :text
      #   universe.send(params[:resources_name]).by(descriptor_for(params[:id])).to_yaml
      # end

    end
  end
end
