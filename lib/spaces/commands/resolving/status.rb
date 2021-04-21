module Resolving
  module Commands
    class Status < Spaces::Commands::Reading

      def assembly
        super.status
      end

      def space_identifier
        super || :resolutions
      end

    end
  end
end
