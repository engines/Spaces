require_relative '../stanza'

module Terraform
  module Stanzas
    class Providers < ::Terraform::Stanza

      def declaratives
        divisions.map(&:stanzas)
      end

      def divisions
        context.division_map[:provider].uniq(&:uniqueness)
      end

    end
  end
end
