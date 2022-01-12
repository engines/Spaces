module Registry
  module Commands
    class Reading < ::Spaces::Commands::Reading

      def assembly
        space.service_by(identifier)
      end

    end
  end
end
