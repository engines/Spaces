module Adapters
  class Emission < ::Spaces::Model

    relation_accessor :arena_emission
    relation_accessor :artifact

    delegate(
      [:arena, :resolution] => :arena_emission,
      division_map: :resolution,
      keys: :division_map,
      order: :artifact
    )

    alias_method :emission, :arena_emission

    def artifact
      @artifact ||= Artifacts::Artifact.new(self)
    end

    def division_adapters
      @division_adapters ||= keys.map do |k|
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

    def adapter_name_elements; nesting_elements ;end
    def default_name_elements; [:default] ;end
    def default_adapter_class; ::Adapters::Default ;end

    def initialize(arena_emission)
      self.arena_emission = arena_emission
    end

  end
end
