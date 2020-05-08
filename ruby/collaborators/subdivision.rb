require_relative 'component'

module Collaborators
  class Subdivision < Component

    relation_accessor :division

    delegate([:collaboration, :installation_path, :context_identifier] => :division)

    def initialize(struct:, division:)
      self.struct = struct
      self.division = division
    end

  end
end
