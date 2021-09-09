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

    end
  end
end
