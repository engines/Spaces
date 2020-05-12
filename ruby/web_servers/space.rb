require_relative '../spaces/space'

module WebServers
  class Space < ::Spaces::Space

    class << self
      def loaded
        ObjectSpace.each_object(Class).select { |k| k < WebServer }
      end
    end

    delegate(loaded: :klass)

    def by(stage)
      i = stage.struct.web_server.identifier
      load(i)
      loaded.detect { |k| k.identifier == i }.new(collaboration: stage, label: :web_server)
    end


    def load(identifier)
      require_relative("#{identifier}/#{identifier}")
    end

  end
end
