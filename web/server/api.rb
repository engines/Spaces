module Server
  class Api < Base

    require_relative '../../ruby/universal/space'
    require_relative '../../ruby/installations/installation'

    post '/projects/:project_id/installations' do
      content_type :text
      installation = Installations::Installation.new blueprint: project, descriptor: descriptor_for(params[:identifier])
      universe.installations.save(installation)
      installation.identifier
    end

    get '/projects/:project_id/installations' do
      universe.installations.descriptors.select do |d|
        d.identifier == project.identifier
      end.to_json
    end

    get '/:resources_name' do
      universe.send(params[:resources_name]).identifiers.to_json
    end

    get '/:resources_name/:id' do
      content_type :text
      universe.send(params[:resources_name]).by(descriptor_for(params[:id])).to_yaml
    end

    private

    def universe
      @universe ||= Universal::Space.new
    end

    def project
      @project ||= universe.blueprints.by(descriptor_for params[:project_id])
    end

    def descriptor_for(id)
      Spaces::Descriptor.new.tap do |m|
        m.identifier = id
      end
    end

  end
end
