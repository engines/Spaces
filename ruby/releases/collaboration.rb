require_relative '../spaces/model'

module Releases
  class Collaboration < ::Spaces::Model

    relation_accessor :predecessor
    relation_accessor :assembly
    relation_accessor :stages

    delegate([:outline, :collaborating_divisions] => :schema)

    def memento; OpenStruct.new(to_h) ;end

    def collaborators
      @collaborators ||= [stages&.map(&:collaborators), collaborator_map.values].flatten.compact
    end

    def stages
      @stages ||= struct.stages&.map { |s| stage_for(s) }
    end

    def collaborator_map
      @collaborator_map ||= keys.inject({}) do |m, k|
        m[k] = protoype_for(k)
        m
      end.compact
    end

    def to_h
      keys.inject({}) do |m, k|
        m[k] =
        if k == :stages
          stages.map(&:memento)
        else
          collaborator_map[k]&.memento || struct[k]
        end
        m
      end.compact
    end

    def schema_keys; schema.keys ;end
    def collaborator_keys; collaborator_map.keys ;end

    def method_missing(m, *args, &block)
      if collaborator_keys.include?(m)
        collaborator_map[m.to_sym] || struct[m]
      else
        assembly&.send(m, *args, &block) || super
      end
    end

    protected

    def stage_for(struct)
      stage_class.new(struct: struct, assembly: self)
    end

    require_relative 'stage'
    def stage_class; Stage ;end

    private

    def protoype_for(key)
      collaborating_divisions[key]&.prototype(collaboration: self, label: key)
    end

  end
end
