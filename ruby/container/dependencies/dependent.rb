require_relative '../docker/collaboration'
require_relative 'relationship'
require_relative 'dependency'

module Container
  class Dependent < Relationship
    include Docker::Collaboration

    relation_accessor :tensor

    class << self
      def step_precedence
        @@dependency_step_precedence ||= { anywhere: [:variables] }
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

    def initialize(struct, tensor)
      self.struct = struct
      self.tensor = tensor
    end

  end
end
