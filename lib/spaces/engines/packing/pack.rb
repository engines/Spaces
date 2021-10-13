module Packing
  class Pack < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(runtime_image: :resolution)

    alias_method :context_identifier, :identifier

    def image_name; runtime_image&.name ;end
    def output_name; runtime_image&.output_name ;end

    def method_missing(m, *args, &block)
      return division_map[m.to_s] if division_keys.include?(m.to_s)
      super
    end

    def respond_to_missing?(m, *)
      division_keys.include?(m.to_s) || super
    end
  end

end
