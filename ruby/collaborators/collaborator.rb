require_relative '../spaces/model'
require_relative '../images/collaboration'
require_relative '../docker/files/collaboration'

module Collaborators
  class Collaborator < ::Spaces::Model
    include Images::Collaboration
    include Docker::Files::Collaboration

    class << self
      def prototype(tensor)
        new(tensor)
      end
    end

    relation_accessor :tensor

    def descriptor
      tensor.descriptor
    end

    def initialize(tensor)
      self.tensor = tensor
    end

  end
end
