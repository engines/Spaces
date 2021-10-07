require_relative 'artifact'

module Providers
  class EmissionAdapter < ::Spaces::Model
    include Artifact

    relation_accessor :arena_emission

    delegate(
      [:arena, :resolution] => :arena_emission,
      division_map: :resolution,
      keys: :division_map
    )

    alias_method :emission, :arena_emission

    def division_adapter_map
      @division_adapter_map ||=
        keys.inject({}) do |m, k|
          m.tap do
            m[k] = division_adapter_for(resolution.division_map[k])
          end.compact
        end
    end

    def division_adapter_for(division)
      adapter_class_for(division).new(division)
    end

    def adapter_class_for(division)
      [nesting_elements, division.qualifier].flatten.constantize #TODO: refactor .flatten.constantize
    rescue NameError => e
      [nesting_elements, default_name_elements].flatten.constantize
    end

    def default_name_elements; [:default_adapter] ;end

    def initialize(arena_emission)
      self.arena_emission = arena_emission
    end

  end
end
