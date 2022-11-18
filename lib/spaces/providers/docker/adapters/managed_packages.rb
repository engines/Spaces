module Adapters
  module Docker
    class ManagedPackages < ::Adapters::ManagedPackages

      def snippets =
        "RUN #{all.map(&:command).join(connector)}"

      def connector = ' && '

    end
  end
end
