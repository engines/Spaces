module Blueprints
  module Importing

    def anchor_descriptors
      @anchor_descriptors ||= struct.bindings&.map { |d| descriptor_class.new(d.descriptor) }
    end

  end
end
