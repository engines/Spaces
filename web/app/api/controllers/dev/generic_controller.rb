module App
  class Api
    module Controllers

      get '/:resources_name' do
        Spaces.universe.send(params[:resources_name]).identifiers.to_json
      end

      get '/:resources_name/:identifier' do
        content_type :text
        Spaces.universe.send(params[:resources_name]).
          by(::Spaces::Descriptor.new(identifier: params[:identifier])).to_yaml
      end

    end
  end
end
