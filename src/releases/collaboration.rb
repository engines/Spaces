require_relative '../spaces/model'

module Releases
  class Collaboration < ::Spaces::Model

    relation_accessor :predecessor

    delegate(
      identifier: :descriptor,
      outline: :schema
    )

    def memento; OpenStruct.new(to_h) ;end

    def divisions; division_map.values ;end

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m[k] = division_for(k)
        m
      end.compact
    end

    def division_for(key)
      schema.divisions[key]&.prototype(stage: self, label: key)
    end

    def to_h
      division_keys.inject({}) do |m, k|
        m[k] = memento_for(k)
        m
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
