require_relative 'producing'
require_relative 'consuming'

module Spaces
  module Streaming
    class Stream < ::Spaces::Model
      include Producing
      include Consuming

      EOT = 4.chr

      attr_accessor :identifier
      relation_accessor :identifiable
      relation_accessor :space

      delegate(streaming_path_for: :space)

      def path; streaming_path_for(identifiable).join("#{identifier}.#{default_extension}") ;end

      def default_extension; :out ;end

      def initialize(identifiable, space:, identifier:)
        self.identifier = identifier || qualifier
        self.identifiable = identifiable
        self.space = space
      end

    end
  end
end
