module Providers
  class Interface < ::Spaces::Model
    include ::Spaces::Streaming

      relation_accessor :emission

      def uniqueness; [klass.name, emission&.identifier] ;end

      def execute(instruction); send(instruction) ;end

      def initialize(emission)
        self.emission = emission
      end

  end
end
