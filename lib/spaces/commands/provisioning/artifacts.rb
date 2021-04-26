module Provisioning
  module Commands
    class Artifacts < Spaces::Commands::Reading

      def assembly
        super.artifact
      end

      def space_identifier
        super || :provisioning
      end

    end
  end
end
