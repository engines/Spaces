require_relative 'arena'

module Artifacts
  module Terraform
    class Initial < Arena

      def stanza_qualifiers; [:initial] ;end

    end
  end
end
