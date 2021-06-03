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

  class Pack < ::Emissions::Emission
    include Payloading

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      resolutions: :universe,
      [:arena, :connect_bindings, :images] => :resolution
    )

    def predecessor; @predecessor ||= resolutions.by(identifier) ;end

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier

    def keys; composition.keys ;end

    def packers; provisioners ;end

    def connections_packed
      connections.map(&:packed)
    end

    def provider_aspect_name_elements
      ['providers', packing_identifier]
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
