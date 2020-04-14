module Server

  class Base < Sinatra::Base

      set :logging, true

      not_found do
        content_type :text
        status 404
        "Server 404. Route not found: #{ request.request_method } '#{ request.path_info }'."
      end

  end

end
