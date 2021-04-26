module Packing

  module Payloading
    def artifact
      keys.inject({}) do |m, k|
        m.tap { m[k] = artifact_for(k) }
      end.compact
    end

    def artifact_for(key)
      division_map[key]&.packing_artifact || struct[key].to_h
    end
  end

  class Pack < ::Emissions::Emission
    include Payloading

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:arena, :connect_bindings, :images] => :resolution,
      post_processor_artifacts: :images
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
