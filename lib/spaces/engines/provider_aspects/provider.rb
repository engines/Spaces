require_relative 'provider_aspect'

module Providers
  class Provider < ProviderAspect

    class << self
      def constant_for(division)
        Module.const_get("::Providers::#{type_for(division).to_s.camelize}")
      end

      def type_for(division)
        division.struct.type
      end
    end

    delegate type: :division

    def required_stanza; end

  end
end
