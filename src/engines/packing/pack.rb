module Packing
  class Pack < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:identifier, :has?, :images, :targets, :content] => :resolution,
      post_processor_stanzas: :images
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier

    def keys; composition.keys ;end

    def packers; provisioners ;end

    def method_missing(m, *args, &block)
      return division_map[m.to_s] if division_keys.include?(m.to_s)
      super
    end

    def respond_to_missing?(m, *)
      division_keys.include?(m.to_s) || super
    end

  end
end
