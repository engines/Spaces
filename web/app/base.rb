require './src/spaces/models/controller'

module App
  class Base < Sinatra::Base

      set sessions: true,
          session_secret: ENV.fetch('SESSION_SECRET') { Sinatra::Base.development? ? '0' : SecureRandom.hex(64) },
          session_timeout_seconds: (ENV['SESSION_TIMEOUT_MINUTES'] || 15).to_f * 60,
          show_exceptions: false,
          dump_errors: Sinatra::Base.development?,
          logging: Sinatra::Base.development? ? Logger::DEBUG : Logger::INFO,
          root: File.dirname(__FILE__)

      configure do
        mime_type :javascript, 'application/javascript'
        mime_type :json, 'application/json'
        mime_type :terminal, 'text/terminal'
      end

      before do
        content_type :json
      end

      not_found do
        content_type :text
        status 404
        "Server 404. Route not found: #{request.request_method} '#{request.path_info}'."
      end

      error Spaces::Controller::Error do |e|
        content_type :text
        status e.status
        e.message
      end

      error do |e|
        content_type :terminal
        status 500
        e.full_message.tap { |message| logger.error(message) }
      end

  end
end
