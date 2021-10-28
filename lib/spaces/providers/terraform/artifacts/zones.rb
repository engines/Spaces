require_relative 'arena'

module Artifacts
  module Terraform
    class Zones < Arena

      def stanza_qualifiers; [:zones] ;end

    end
  end
end
