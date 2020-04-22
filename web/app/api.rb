require './ruby/projects/controller'
require './ruby/installations/controller'
require './web/app/api/resources'

module App
  class Api < Base

    helpers Sinatra::Cookies
    helpers Sinatra::Streaming

    class << self
      def resources(name, parent=nil)
        r = Resources.new(self, name, parent)
        r.build
        yield r if block_given?
      end
    end

    resources(:projects) do |r|
      r.resources(:installations)
    end

    resources(:installations)

  end
end
