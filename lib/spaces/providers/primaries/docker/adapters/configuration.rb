module Adapters
  module Docker
    class Configuration < ::Adapters::Configuration

      delegate to_h: :division

      def snippets
        (h = to_h).keys.map { |k| statement(k, h[k]) }.join(connector)
      end

      def statement(key, value); %(ENV #{key} "#{value}") ;end

      def connector; "\n" ;end

    end
  end
end
