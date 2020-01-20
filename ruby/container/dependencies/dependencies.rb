require_relative '../../spaces/model'
require_relative '../docker/collaboration'
require_relative 'dependent'

module Container
  class Dependencies < ::Spaces::Model
    include Docker::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    relation_accessor :tensor

    def layers_for(group)
      all.map { |a| a.layers_for(group) }
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
