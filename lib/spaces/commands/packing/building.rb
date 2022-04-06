module Packing
  module Commands
    class Building < Spaces::Commands::Executing

      def instruction; :build ;end

      def payload
        return super unless result&.class == Packer::Output::Build

        if (e = result.errors).any?
          { errors: e.map(&:error) }
        else
          { result: result.artifacts.map(&:string) }
        end
      end

    end
  end
end
