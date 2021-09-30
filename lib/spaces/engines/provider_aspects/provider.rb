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
      [:by, :path_for] => :space
    )

    def aspect_name_elements; name_array.map(&:downcase) ;end

    # def required_stanza; end #TODO: TERRAFORM SPECIFIC?

    def initialize(emission, space = nil)
      super(emission)
      self.space = space
    end

  end
end
