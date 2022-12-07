require_relative 'artifact'

module Artifacts
  module Terraform
    class Resources < Artifact

      def stanza_qualifiers = [:resources]

    end
  end
end
