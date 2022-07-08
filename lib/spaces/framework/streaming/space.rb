require_relative 'producing'
require_relative 'consuming'

module Streaming
  class Space < ::Spaces::PathSpace
    include Producing
    include Consuming

    class << self
      def default_model_class = self
    end

    def identifier =
      [:streaming, segments].flatten.join(identifier_separator).as_path

    def path =
      super.dirname.join(super.dirname, "#{super.basename}.#{default_extension}")

    def by(args) = default_model_class.new(args)

    def default_extension = :out

    def identifier_separator = ''.identifier_separator
    def eot = 4.chr

    def initialize(segments)
      self.struct = OpenStruct.new(segments: [segments].flatten.map(&:identifier))
    end

  end
end
