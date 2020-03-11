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

    def product
      all.map { |a| a.product }
    end

    def binding_class
      Binding
    end

  end
end
