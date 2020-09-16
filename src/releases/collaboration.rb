require_relative 'component'

module Releases
  class Collaboration < Component

    relation_accessor :predecessor

    delegate(
      identifier: :descriptor,
      outline: :schema
    )

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
