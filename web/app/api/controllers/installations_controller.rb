module App
  class Api
    module Controllers

      before '/installations/:installation_id/?*' do
        set_installation
      end

      get '/installations' do
        Spaces.installations.to_json
      end

      get '/installations/:installation_id' do
        @installation.to_json
      end

      delete '/installations/:installation_id' do
        @installation.delete
        'true'
      end

      helpers do
        def set_installation
          @installation = Spaces.installations.by(params[:installation_id])
        end
      end

    end
  end
end
