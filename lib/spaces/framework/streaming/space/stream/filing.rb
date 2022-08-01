module Streaming
  class Filing < ::Spaces::PathSpace
    include Producing
    include Consuming
    include Writing

    class << self
      def default_model_class; self ;end
    end

    def path
      super.dirname.join(super.dirname, "#{super.basename}.#{default_extension}")
    end

    def by(args)
      default_model_class.new(args)
    end

    def default_extension; :out ;end

    def eot; 4.chr ;end

    def identifier = @stream.identifier

    def initialize(stream)
      @stream = stream
    end

  end
end
