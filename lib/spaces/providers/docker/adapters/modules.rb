module Adapters
  module Docker
    class Modules < ::Adapters::Modules

      def snippets_for(language)
        "RUN #{division.send(language).inline.join(connector)}"
      end

      def connector; ' && ' ;end

    end
  end
end
