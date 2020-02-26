require_relative '../tensors/collaborator'
require_relative '../docker/files/collaboration'
require_relative 'binding'

module Bindings
  class Bindings < ::Tensors::Collaborator

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    def layers_for(group)
      all.map { |a| a.layers_for(group) }
    end

    def all
      @all ||= tensor.struct.dependencies.map { |d| binding_class.new(struct: d, context: self) }
    end

    def named(name)
      all.detect { |d| d.name == name }
    end

    def binding_class
      Binding
    end

  end
end
