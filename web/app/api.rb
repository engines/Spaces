module App
  class Api < Base

    require './web/app/api/models'
    require './web/app/api/controllers'

    register Controllers
    helpers Sinatra::Cookies
    helpers Sinatra::Streaming

  end
end
