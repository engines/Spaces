module Adapters
  class Emission < ::Spaces::Model

    relation_accessor :provider
    relation_accessor :arena_emission
    relation_accessor :artifact

    delegate(
      qualifier: :provider,
      [:arena, :resolution, :blueprint_identifier] => :arena_emission,
      division_map: :resolution,
      keys: :division_map,
      order: :artifact
    )

    alias_method :emission, :arena_emission

    def artifact
      @artifact ||= artifact_class.new(self)
    end

    def artifact_class
      class_for(:artifacts, qualifier, :artifact)
    rescue NameError
      default_artifact_class
    end

    def division_adapters
      @division_adapters ||= resolution.keys.map do |k|
        division_adapter_for(resolution.division_map[k])
      end.compact
    end

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
    def default_adapter_class; ::Adapters::Default ;end

    def initialize(provider, arena_emission)
      self.provider = provider
      self.arena_emission = arena_emission
    end

    def method_missing(m, *args, &block)
      return resolution.send(m, *args, &block) if resolution.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      resolution.respond_to?(m) || super
    end

  end
end
