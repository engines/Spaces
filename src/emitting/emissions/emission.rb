require_relative 'transformable'
require_relative 'composition'

module Emitting
  class Emission < Transformable

    class << self
      def composition_class; Composition ;end
    end

    relation_accessor :predecessor

    delegate(
      blueprints: :universe,
      identifier: :descriptor
    )

    alias_method :has?, :respond_to?

    def count
      has?(:scaling) ? scaling.count : 1
    end

    def context_identifier; identifier ;end

    def emit; OpenStruct.new(to_h) ;end

    def divisions; division_map.values ;end

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m.tap do
          m[k] = division_for(k)
        end
      end.compact
    end

    def division_for(key)
      composition.divisions[key]&.prototype(emission: self, label: key)
    end

    def to_h
      division_keys.inject({}) do |m, k|
        m.tap { m[k] = emit_for(k) }
      end.compact
    end

    def emit_for(key)
      division_map[key]&.emit || struct[key]
    end

    def composition_keys; composition.keys ;end
    def division_keys; division_map.keys ;end

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
