require_relative 'artifact'

module Artifacts
  module CloudFormation
    class Resources < Artifact

      def stanza_qualifiers = [:resources]

    end
  end
end
