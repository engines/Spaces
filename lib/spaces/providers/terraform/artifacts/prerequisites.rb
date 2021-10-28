require_relative 'arena'

module Artifacts
  module Terraform
    class Prerequisites < Arena

      def stanza_qualifiers; [:providers] ;end

    end
  end
end
