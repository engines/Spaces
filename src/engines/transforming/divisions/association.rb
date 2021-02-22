require_relative 'division'

module Divisions
  class Association < Division

    class << self
      def prototype(emission:, label:)
        new(emission: emission, label: label)
      end
    end

  end
end
