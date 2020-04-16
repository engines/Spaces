module App
  class Api
    module Controllers

      extend Sinatra::Extension
      include Models

      App.require_files('./web/app/api/controllers/**/*.rb')

    end
  end
end
