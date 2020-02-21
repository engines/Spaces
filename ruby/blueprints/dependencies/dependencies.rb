require_relative '../../collaborators/collaborator'
require_relative '../../docker/files/collaboration'
require_relative 'dependent'

module Blueprints
  class Dependencies < ::Collaborators::Collaborator

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    def layers_for(group)
      all.map { |a| a.layers_for(group) }
    end

    def all
      @all ||= tensor.struct.dependencies.map { |d| dependent_class.new(struct: d, context: self) }
    end

    def named(name)
      all.detect { |d| d.name == name }
    end

    def dependent_class
      Dependent
    end

  end
end
