module Packing
  class Pack < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:identifier, :has?, :images, :system_packages, :packing, :binding_descriptors, :auxiliary_content] => :resolution,
      post_processor_stanzas: :images
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :keys, :composition_keys

    def export; struct_for(images.all.map(&:export)) ;end
    def emit; super.merge(struct_for(images.all.map(&:commit))) ;end

    def struct_for(images); OpenStruct.new(builders: images) ;end

    def script_file_names; resolution.packing_script_file_names ;end

    def initialize(resolution)
      self.struct = struct_for(resolution.images)
      self.struct.identifier = resolution.identifier
      self.resolution = resolution
    end

  end
end
