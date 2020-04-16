module Server
  class Api < Base

    require './web/server/api/models'
    require './web/server/api/controllers'

    register Controllers
    helpers Sinatra::Cookies
    helpers Sinatra::Streaming

    private

    # def project
    #   @project ||= universe.blueprints.by(descriptor_for params[:project_id])
    # end
    #
    # def descriptor_for(id)
    #   Spaces::Descriptor.new.tap do |m|
    #     m.identifier = id
    #   end
    # end

  end
end
