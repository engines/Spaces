require './web/app/api/routes'

module App
  class Api < Base

    helpers Sinatra::Cookies
    helpers Sinatra::Streaming

    register Routes

  end
end
