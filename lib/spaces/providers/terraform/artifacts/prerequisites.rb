require_relative 'arena'

module Artifacts
  module Terraform
    class Prerequisites < Arena

      def stanza_qualifiers; [:provider] ;end

    end
  end
end
