require_relative '../installations/collaborator'
require_relative '../docker/files/collaboration'
require_relative 'binding'

module Bindings
  class Bindings < ::Installations::Collaborator

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    def layers_for(group)
      all.map { |a| a.layers_for(group) }
    end

    def all
      @all ||= installation.struct.bindings.map { |d| binding_class.new(struct: d, context: self) }
    end

    def named(name)
      all.detect { |d| d.name == name }
    end

    def resolved
      all.reduce({}) do |m, a|
        m[a.name] = a.resolved
        m
      end
    end

    def binding_class
      Binding
    end

    def to_yaml
      YAML.dump(resolved)
    end

  end
end
