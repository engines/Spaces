require_relative '../spaces/space'

module Frameworks
  class Space < ::Spaces::Space

    def by(tensor)
      i = tensor.struct.framework.identifier
      load(i)
      loaded.detect { |k| k.identifier == i }.new(tensor)
    end

    def loaded
      ObjectSpace.each_object(Class).select { |k| k < Framework }
    end

    def load(identifier)
      require_relative("#{identifier}/#{identifier}")
    end

  end
end
