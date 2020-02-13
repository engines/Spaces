require_relative '../../docker/files/collaboration'
require_relative 'relationship'
require_relative 'dependency'

module Blueprints
  class Dependent < Relationship
    include Docker::Files::Collaboration

    relation_accessor :context

    class << self
      def step_precedence
        @@dependent_step_precedence ||= { anywhere: [:variables] }
      end
    end

    def dependency
      @dependency ||= dependency_class.new(struct)
    end

    def dependency_class
      Dependency
    end

    def descriptor
      dependency.descriptor
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
