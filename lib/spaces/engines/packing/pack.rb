module Packing
  class Pack < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(runtime_image: :resolution)

    alias_method :context_identifier, :identifier

    # def packers; provisioners ;end

    # def connections_packed
    #   connections.map(&:packed)
    # end

    # def aspect_name_elements
    #   [super, [packtime_qualifier] * 2].flatten #TODO: refactor uses of '] * 2]'
    # end

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
