module Imaging
  module Commands
    class Building < Spaces::Commands::Executing

      def execution_instruction; :build ;end

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

    end
  end
end
