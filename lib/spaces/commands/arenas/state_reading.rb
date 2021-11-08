module Arenas
  module Commands
    class StateReading < ::Spaces::Commands::Reading

      def assembly
        super.state.struct
      rescue NoMethodError
        raise ::Spaces::Errors::CommandFail, {method_missing: :state, input: input}
      end

    end
  end
end
