require_relative '../../spaces/model'
require_relative '../docker/collaboration'
require_relative 'dependent'

module Container
  class Dependencies < ::Spaces::Model
    include Docker::Collaboration

    relation_accessor :tensor

    def layers
      all.map { |a| a.layers }
    end

    def all
      @all ||= struct.map { |d| dependent_class.new(d, tensor) } || []
    end

    def dependent_class
      Dependent
    end

    def initialize(struct, tensor)
      self.struct = struct
      self.tensor = tensor
    end

  end
end
