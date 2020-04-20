require_relative '../spaces/space'

module Frameworks
  class Space < ::Spaces::Space

    class << self
      def loaded
        ObjectSpace.each_object(Class).select { |k| k < Framework }
      end
    end

    delegate(loaded: :klass)

    def by(installation)
      i = installation.struct.framework.identifier
      load(i)
      loaded.detect { |k| k.identifier == i }.new(installation: installation, blueprint_label: :framework)
    end

    def load(identifier)
      require_relative("#{identifier}/#{identifier}")
    end

  end
end
