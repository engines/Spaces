require_relative 'component'

module Collaborators
  class Collaborator < Component

    class << self
      def prototype(collaboration:, label:)
        new(collaboration: collaboration, label: label)
      end
    end

    attr_accessor :label

    def related_collaborators
      @related_collaborators ||= collaboration.collaborators
    end

    def initialize(struct: nil, collaboration: nil, label: nil)
      self.collaboration = collaboration
      self.label = label
      self.struct = struct || collaboration&.struct[label] || default
    end

    def default ;end

  end
end
