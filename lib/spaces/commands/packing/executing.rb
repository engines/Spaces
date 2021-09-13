module Packing
  module Commands
    class Executing < Spaces::Commands::Executing

      def payload
        return super unless result&.class == Packer::Output::Build

        if (e = result.errors).any?
          { errors: e.map(&:error) }
        else
          { result: result.artifacts.map(&:string) }
        end
      end

      def space_identifier
        super || :packs
      end

      def execute(&block)
        space.send(execution_instruction, model, &block)
      end

      protected

      def commit(&block)
        input[:threaded] ? outputting(&block) : execute(&block)
      end

      def outputting(&block)
        Spaces::Outputting::Build
        .new(command: self, identifier: input[:identifier])
        .write(&block)
      end

    end
  end
end
