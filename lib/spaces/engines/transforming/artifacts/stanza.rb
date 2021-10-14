require_relative 'artifact'

module Artifacts
  class Stanza < Artifact

    relation_accessor :artifact

    # delegate(
    #   snippets_for: :artifact
    # )

    def initialize(artifact)
      self.artifact = artifact
    end

  end
end
