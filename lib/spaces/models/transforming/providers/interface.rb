module Providers
  class Interface < ::Spaces::Model
    include ::Spaces::Streaming

      relation_accessor :emission

      def initialize(emission)
        self.emission = emission
      end

  end
end
