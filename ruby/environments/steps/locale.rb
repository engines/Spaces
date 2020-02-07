require_relative 'requires'

module Environments
  class Environment
    class Locale < Docker::Files::Step

      def content
        %Q(
        ENV LANGUAGE '#{context.locale.language}'
        ENV LANG '#{context.locale.lang}'
        ENV LC_ALL '#{context.locale.lc_all}'
        )
      end

    end
  end
end
