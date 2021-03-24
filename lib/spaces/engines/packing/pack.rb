module Packing

  module Payloading
    def payload
      keys.inject({}) do |m, k|
        m.tap { m[k] = payload_for(k) }
      end.compact
    end

    def payload_for(key)
      division_map[key]&.packing_payload || struct[key].to_h
    end
  end

  class Pack < ::Emissions::Emission
    include Payloading

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:arena, :connect_targets, :images] => :resolution,
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
