require_relative 'emission'

module Adapters
  class ResolvedEmission < Emission

    relation_accessor :provider
    relation_accessor :arena_adapter

    delegate(
      [:arena, :resolution, :blueprint_identifier] => :emission,
      division_map: :resolution,
      keys: :division_map
    )

    # TODO: possible refactor ... the levels of dynamic class generation are a repeating pattern
    def adapter_map
      @adapter_map ||= resolution.keys.inject({}) do |m, k|
        m.tap { m[k] = division_adapter_for(resolution.division_map[k]) }
      end.compact
    end

    def adapters; adapter_map.values ;end
    def adapter_keys; adapter_map.keys ;end

    def division_adapter_for(division)
      adapter_class_for(division).new(division)
    end

    def adapter_class_for(division)
      q = division.qualifier
      class_for(adapter_name_elements, q)
    rescue NameError
      begin
        class_for(nesting_elements, q)
      rescue NameError
        begin
          class_for(adapter_name_elements, default_name_elements)
        rescue NameError
          default_adapter_class
        end
      end
    end

    def adapter_name_elements; nesting_elements ;end
    def default_name_elements; [:default] ;end
    def default_adapter_class; Default ;end
    def default_emission_adapter_class; EmissionDefault ;end

    def method_missing(m, *args, &block)
      return resolution.send(m, *args, &block) if resolution.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      resolution.respond_to?(m) || super
    end

  end
end
