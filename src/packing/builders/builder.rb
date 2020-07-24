require_relative '../../releases/subdivision'

module Packing
  module Builders
    class Builder < ::Releases::Subdivision

      class << self
        def qualifier
          name.split('::').last.downcase
        end
      end

      def identifier
        name
      end

    end
  end
end
