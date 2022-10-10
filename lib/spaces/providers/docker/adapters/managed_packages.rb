module Adapters
  module Docker
    class ManagedPackages < ::Adapters::ManagedPackages

      def snippets_for(language) = "RUN #{division.send(language).inline.join(connector)}"

      def connector = ' && '

    end
  end
end
