require_relative 'artifact'

module Artifacts
  class Format < Artifact

    alias_method :stanza, :holder

  end
end
