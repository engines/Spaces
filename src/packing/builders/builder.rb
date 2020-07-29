require_relative '../../releases/subdivision'

module Packing
  module Builders
    class Builder < ::Releases::Subdivision

      class << self
        def qualifier
          name.split('::').last.downcase
        end

        def safety_overrides; {} ;end
      end

      delegate(safety_overrides: :klass)

      def identifier
        type
      end

      def initialize(struct:, division:)
        self.struct = struct.merge(OpenStruct.new(safety_overrides))
        self.division = division
      end

    end
  end
end
