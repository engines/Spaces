require_relative 'aspect'

module ProviderAspects
  class Provider < Aspect

    class << self
      def prototype(emission, space)
        constant_for(emission).new(emission, space)
      end
    end

    relation_accessor :space

    alias_method :emission, :division

    delegate(
      [:type, :descriptor] => :emission,
      [:by, :save, :path_for] => :space
    )

    def required_stanza; end

    def initialize(emission, space = nil)
      super(emission)
      self.space = space
    end

  end
end
