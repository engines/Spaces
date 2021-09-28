module Providers
  module Docker
    class Configuration < ::ProviderAspects::Configuration

      delegate to_h: :division

      def packing_artifact
        (h = to_h).keys.map { |k| statement(k, h[k]) }.join(connector)
      end

      def statement(key, value); %(ENV #{key} "#{value}") ;end

      def connector; "\n" ;end

    end
  end
end
