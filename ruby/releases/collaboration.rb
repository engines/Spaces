require_relative '../spaces/model'

module Releases
  class Collaboration < ::Spaces::Model

    relation_accessor :predecessor

    delegate([:outline, :collaborating_divisions] => :schema)

    def memento; OpenStruct.new(to_h) ;end

    def collaborators; collaborator_map.values ;end

    def collaborator_map
      @collaborator_map ||= keys.inject({}) do |m, k|
        m[k] = collaborator_for(k)
        m
      end.compact
    end

    def collaborator_for(key)
      collaborating_divisions[key]&.prototype(collaboration: self, label: key)
    end

    def to_h
      keys.inject({}) do |m, k|
        m[k] = memento_for(k)
        m
      end.compact
    end

    def memento_for(key)
      collaborator_map[key]&.memento || struct[key]
    end

    def schema_keys; schema.keys ;end
    def collaborator_keys; collaborator_map.keys ;end

    def method_missing(m, *args, &block)
      if collaborator_keys.include?(m)
        collaborator_map[m.to_sym] || struct[m]
      else
        super
      end
    end

  end
end
