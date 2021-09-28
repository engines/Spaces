module Packing

  module Payloading
    def artifact
      keys.inject({}) do |m, k|
        m.tap { m[k] = artifact_for(k) }
      end.compact
    end

    def artifact_for(key)
      division_map[key]&.provider_aspect&.packing_artifact
    end
  end

  class Pack < ::Resolving::Emission
    include Payloading

    class << self
      def composition_class; Composition ;end
    end

    delegate(runtime_image: :resolution)

    alias_method :context_identifier, :identifier

    def packers; provisioners ;end

    def connections_packed
      connections.map(&:packed)
    end

    def aspect_name_elements
      ['providers', [packing_identifier] * 2].flatten
    end

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
