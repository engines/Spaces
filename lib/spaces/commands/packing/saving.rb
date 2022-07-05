require_relative 'asserting'

module Packing
  module Commands
    class Saving < ::Spaces::Commands::Saving
      include Asserting

      def model
        @model ||= resolution.packed
      end

      def resolution = universe.resolutions.by(identifier)

    end
  end
end
