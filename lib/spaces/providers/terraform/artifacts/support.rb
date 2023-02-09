require_relative 'arena'

module Artifacts
  module Terraform
    class Support < Arena

      # TODO ... this is probably dead until local compute is reinstated
      def stanza_qualifiers = [:zones]

    end
  end
end
