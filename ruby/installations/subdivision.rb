require_relative '../spaces/model'
require_relative '../docker/files/collaboration'
require_relative '../images/collaboration'

module Installations
  class Subdivision < ::Spaces::Model
    include Docker::Files::Collaboration
    include Images::Collaboration

    relation_accessor :context

    delegate(installation: :context)

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
