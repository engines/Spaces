require_relative '../spaces/model'
require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module Tensors
  class Collaborator < ::Spaces::Model
    include Images::Collaboration
    include Docker::Files::Collaboration

    class << self
      def prototype(tensor:, section:)
        new(tensor: tensor, section: section)
      end
    end

    relation_accessor :tensor

    def descriptor
      tensor.descriptor
    end

    def initialize(struct: nil, tensor: nil, section: nil)
      self.tensor = tensor
      self.struct = struct || tensor&.struct[section] || default
    end

    def default; end

  end
end
