require_relative '../../docker/files/step'

module Environments
  module Steps
    class Locale < Docker::Files::Step

      def instructions
        # %Q(
        # ENV LANGUAGE '#{context.locale.language}'
        # ENV LANG '#{context.locale.lang}'
        # ENV LC_ALL '#{context.locale.lc_all}'
        # )
      end

    end
  end
end
