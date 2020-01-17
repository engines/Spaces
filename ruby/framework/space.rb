require_relative '../spaces/space'

module Framework
  class Space < ::Spaces::Space

    def by(descriptor)
      load(descriptor.identifier)
      loaded.detect { |k| k.identifier == descriptor.identifier }.new
    end

    def loaded
      ObjectSpace.each_object(Class).select { |k| k < Framework }
    end

    def load(identifier)
      require_relative("#{identifier}/#{identifier}")
    end

  end
end
