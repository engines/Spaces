require_relative 'asserting'

module Packing
  module Commands
    class Building < Spaces::Commands::Executing
      include Asserting

      def instruction = :build

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
