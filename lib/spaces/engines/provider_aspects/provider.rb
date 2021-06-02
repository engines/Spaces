require_relative 'aspect'

module ProviderAspects
  class Provider < Aspect

    class << self
      def prototype(division, space)
        constant_for(division).new(space)
      end

      def constant_for(division)
        Module.const_get("::Providers::#{type_for(division).to_s.camelize}")
      end

      def type_for(division)
        division.struct.type
      end
    end

    relation_accessor :space

    delegate(
      type: :division,
      [:by, :save, :path_for] => :space
    )

    def required_stanza; end

    def initialize(division, space = nil)
      super(division)
      self.space = space
    end

  end
end
