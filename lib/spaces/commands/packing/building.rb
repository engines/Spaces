require_relative 'asserting'

module Packing
  module Commands
    class Building < Spaces::Commands::Executing
      include Asserting

      def instruction = :build

    end
  end
end
