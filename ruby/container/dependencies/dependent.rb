require_relative 'relationship'
require_relative 'dependency'

module Container
  class Dependent < Relationship

    relation_accessor :tensor

    class << self
      def step_precedence
        @@dependency_step_precedence ||= [:variables]
      end
    end

    def layers
      step_precedence.each { |s| require_relative "steps/#{s}" }
      super
    end

    def step_module_name
      "Container::Dependency"
    end

    def dependency
      @dependency ||= dependency_class.new(struct.descriptor)
    end

    def dependency_class
      Dependency
    end

    def descriptor
      tensor.descriptor
    end

    def initialize(struct, tensor)
      self.struct = struct
      self.tensor = tensor
    end

  end
end
