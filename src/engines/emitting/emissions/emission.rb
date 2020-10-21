require_relative 'transformable'

module Emissions
  class Emission < Transformable

    class << self
      def composition; @composition ||= composition_class.new ;end
      def composition_class; Composition ;end
    end

    relation_accessor :predecessor

    delegate(
      [:universe, :composition] => :klass,
      blueprints: :universe
    )

    alias_method :emission, :itself
    alias_method :has?, :respond_to?

    def emit; OpenStruct.new(to_h) ;end

    def complete?
      all_complete?(divisions) && mandatory_divisions_present?
    end

    def incomplete_divisions
      divisions.reject(&:complete?)
    end

    def mandatory_divisions_present?
      division_keys & mandatory_keys == mandatory_keys
    end

    def stanzas_content
      stanzas.join("\n")
    end

    def stanzas
      divisions.map(&:stanzas)
    end

    def divisions; division_map.values ;end

    def count
      has?(:scaling) ? scaling.count : 1
    end

    def context_identifier; identifier ;end

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m.tap do
          m[k] = division_for(k)
        end
      end.compact
    end

    def to_h
      division_keys.inject({}) do |m, k|
        m.tap { m[k] = emit_for(k) }
      end.compact
    end

    def composition_keys; composition.keys ;end
    def division_keys; division_map.keys ;end

    def division_for(key)
      composition.divisions[key]&.prototype(emission: self, label: key)
    end

    def emit_for(key)
      division_map[key]&.emit || struct[key]
    end

    def descriptors_for(division_identifier)
      descriptors_structs_for(division_identifier).map { |d| descriptor_class.new(d) }.uniq(&:uniqueness)
    end

    def descriptors_structs_for(division_identifier)
      (struct[division_identifier] || []).map { |d| d[:descriptor] }.compact
    end

    def blueprint_file_names_for(directory)
      blueprints.file_names_for(directory, context_identifier)
    end

    def interpolating_class; Interpolating::FileText ;end

    def method_missing(m, *args, &block)
      pp m
      if division_keys.include?(m)
        division_map[m.to_sym] || struct[m]
      else
        super
      end
    end

    def respond_to_missing?(m, *)
      division_keys.include?(m) || super
    end

  end
end
