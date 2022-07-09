require_relative 'producing'
require_relative 'consuming'

module Streaming
  class Filing < ::Spaces::PathSpace
    include Producing
    include Consuming

    class << self
      def default_model_class; self ;end
    end

    def initialize(stream)
      @stream = stream
    end

    def path
      super.dirname.join(super.dirname, "#{super.basename}.#{default_extension}")
    end

    def by(args)
      default_model_class.new(args)
    end

    def default_extension; :out ;end

    def eot; 4.chr ;end

  end
end
