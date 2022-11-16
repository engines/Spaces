module Adapters
  module Docker
    class BundledPackages < ::Adapters::BundledPackages

     def snippets =
        "RUN #{all.map(&:command).join(connector)}"

      def connector = '&&'

    end
  end
end
