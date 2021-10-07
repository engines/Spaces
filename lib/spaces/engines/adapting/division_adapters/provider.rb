# TODO: still required?

module Adapters
  class Provider < DivisionAdapter

    class << self
      def prototype(emission, space)
        constant_for(emission).new(emission, space)
      end
    end

    relation_accessor :space

    alias_method :emission, :division

    delegate(
      [:type, :descriptor] => :emission,
      [:by, :path_for] => :space
    )

    # def required_stanza; end #TODO: TERRAFORM SPECIFIC?

    def initialize(emission, space = nil)
      super(emission)
      self.space = space
    end

  end
end
