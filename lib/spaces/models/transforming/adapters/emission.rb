require_relative 'adapter'

module Adapters
  class Emission < Adapter

    relation_accessor :provider
    relation_accessor :resolved_emission

    delegate(
      qualifier: :provider,
      [:arena, :resolution, :blueprint_identifier] => :resolved_emission,
      division_map: :resolution,
      keys: :division_map
    )

    alias_method :emission, :resolved_emission

    def artifact_qualifiers
      [:artifact]
    end

    def artifacts
      @artifacts ||= artifact_qualifiers.map do |q|
        artifact_class_for(q).new(self)
      end
    end

    def artifact_class_for(artifact_qualifier)
      class_for(:artifacts, qualifier, artifact_qualifier)
    rescue NameError
      default_artifact_class
    end

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

    def default_artifact_class; ::Artifacts::Artifact ;end
    def adapter_name_elements; nesting_elements ;end
    def default_name_elements; [:default] ;end
    def default_adapter_class; Default ;end
    def default_emission_adapter_class; EmissionDefault ;end

    def snippet_map; {} ;end

    def initialize(provider, resolved_emission)
      self.provider = provider
      self.resolved_emission = resolved_emission
    end

    def method_missing(m, *args, &block)
      return arena.send(m, *args, &block) if arena.respond_to?(m)
      return resolution.send(m, *args, &block) if resolution.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      arena.respond_to?(m) || resolution.respond_to?(m) || super
    end

  end
end
