module Arenas
  module Commands
    class MoreOrganizations < ::Spaces::Commands::Reading

      def assembly
        model.more_organization_identifiers
      end

      def space_identifier
        super || :arenas
      end

    end
  end
end
