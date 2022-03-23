require_relative 'producing'
require_relative 'consuming'

module Spaces
  module Streaming
    class Stream < ::Spaces::Model
      include ::Spaces::Paths
      include Producing
      include Consuming

      attr_accessor :identifier
      relation_accessor :identifiable

      def universes; ::Spaces::Space.universes ;end

      def path; streaming_path_for(identifiable).join("#{identifier}.#{default_extension}") ;end

      def default_extension; :out ;end
      def eot; 4.chr ;end

      def initialize(identifiable, identifier:)
        self.identifier = identifier || qualifier
        self.identifiable = identifiable
      end

    end
  end
end
