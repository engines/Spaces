require_relative 'artifact'

module Artifacts
  class Stanza < Artifact

    relation_accessor :artifact

    delegate(
      delegate([:blueprint_identifier, :division_adapter_keys, :division_adapters] => :artifact)
    )

    def initialize(artifact)
      self.artifact = artifact
    end

    def method_missing(m, *args, &block)
      return artifact.send(m, *args, &block) if artifact.respond_to?(m)
      super
    end

    def respond_to_missing?(m, *)
      artifact.respond_to?(m) || super
    end

  end
end
