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

    def packers; division_map['provisioners'] ;end

    def struct_for(images); OpenStruct.new(builders: images) ;end

    def script_file_names; resolution.packing_script_file_names ;end

    def initialize(resolution)
      self.struct = struct_for(resolution.images)
      self.struct.identifier = resolution.identifier
      self.resolution = resolution
    end

    def method_missing(m, *args, &block)
      return division_map[m.to_s] if division_keys.include?(m.to_s)
      super
    end

    def respond_to_missing?(m, *)
      division_keys.include?(m.to_s) || super
    end

  end
end
