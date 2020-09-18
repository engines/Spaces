require_relative 'division'

module Releases
  class Release < Division

    relation_accessor :predecessor

    delegate(
      blueprints: :universe,
      identifier: :descriptor,
      outline: :schema
    )

    alias_method :has?, :respond_to?

    def count
      has?(:scaling) ? scaling.count : 1
    end

    def context_identifier; identifier ;end

    def memento; OpenStruct.new(to_h) ;end

    def divisions; division_map.values ;end

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m.tap do
          m[k] = division_for(k)
        end
      end.compact
    end

    def division_for(key)
      schema.divisions[key]&.prototype(collaboration: self, label: key)
    end

    def to_h
      division_keys.inject({}) do |m, k|
        m.tap { m[k] = memento_for(k) }
      end.compact
    end

    def memento_for(key)
      division_map[key]&.memento || struct[key]
    end

    def schema_keys; schema.keys ;end
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

    def text_class; Texts::FileText ;end

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
