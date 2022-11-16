require_relative 'emission'

module Adapters
  class ResolvedEmission < Emission

    relation_accessor :arena_adapter

    delegate(
      resolutions: :universe,
      [:arena, :resolution, :blueprint_identifier] => :emission,
      resolution_default_division_keys: :arena,
      [:provider_for, :qualifier_for] => :arena,
      [:image_identifier, :division_map] => :resolution
    )

    # TODO: possible refactor ... the levels of dynamic class generation are a repeating pattern
    def adapter_map
      @adapter_map ||= keys.inject({}) do |m, k|
        m.tap { m[k] = division_adapter_for(resolution.send(k)) }
      end.compact
    end

    def keys =
      [resolution_default_division_keys, division_map.keys].flatten.uniq

    def adapters = adapter_map.values
    def adapter_keys = adapter_map.keys

    def division_adapter_for(division) =
      adapter_class_for(division).new(division)

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

    def adapter_name_elements = nesting_elements
    def default_name_elements = [:default]
    def default_adapter_class = Default
    def default_emission_adapter_class = EmissionDefault

    def method_missing(m, *args, &block)
      return adapter_map[m.to_sym] if adapter_keys.include?(m)
      return resolution.send(m, *args, &block) if resolution.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      adapter_keys.include?(m) || resolution.respond_to?(m) || super
    end

  end
end
