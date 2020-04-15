module Server
  class Api < Base

    require_relative '../../ruby/universal/space'

    get '/:resources_name' do
      universe.send( params[:resources_name] ).identifiers.to_json
    end

    get '/:resources_name/:id' do
      content_type :text
      universe.send( params[:resources_name] ).by( descriptor_for( params[:id] ) ).to_yaml
    end

    private

    def universe
      @universe = Universal::Space.new
    end

    def descriptor_for( id )
      Spaces::Descriptor.new.tap do |m|
        m.identifier = id
      end
    end

  end
end
