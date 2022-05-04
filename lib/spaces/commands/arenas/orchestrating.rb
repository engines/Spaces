module Arenas
  module Commands
    class Orchestrating < ::Spaces::Commands::Iterating
      include ::Orchestrating::Commands::Asserting

      def payload
        r = super.map(&:result).compact
        OpenStruct.new(
          {
            result: (r unless r.empty?),
            errors: struct.errors
          }.compact
        )
      end

      def array
        @array ||= model.directly_bound_resolutions
      end

      def subcommand_inputs
        {space: :orchestrations}
      end

      def subcommand_class; ::Orchestrating::Commands::Saving ;end

      protected

      def _run
        space.save_artifacts_for(current_model).map(&:content)
        super
      end

    end
  end
end
