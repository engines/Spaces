module Arenas
  module Commands
    class MoreBinders < ::Spaces::Commands::Reading

      def assembly
        model.more_binder_identifiers
      end

      # def space_identifier
      #   super(default: :arenas)
      # end

    end
  end
end
