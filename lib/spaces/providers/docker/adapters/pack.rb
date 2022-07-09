module Adapters
  module Docker
    class Pack < ::Adapters::Pack

      def artifact_qualifiers = [:dockerfile]

    end
  end
end
