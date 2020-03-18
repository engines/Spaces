require_relative '../spaces/space'

module WebServers
  class Space < ::Spaces::Space

    def by(context)
      i = context.struct.web_server.identifier
      load(i)
      loaded.detect { |k| k.identifier == i }.new(context)
    end

    def loaded
      ObjectSpace.each_object(Class).select { |k| k < WebServer }
    end

    def load(identifier)
      require_relative("#{identifier}/#{identifier}")
    end

  end
end
