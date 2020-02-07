require_relative 'requires'

module Docker
  class File < ::Spaces::Product
    class Adds < Docker::File::Step

      def content
        %Q(
        ADD scripts /scripts
        ADD home home
        ADD engines home/engines
        ADD home/start.sh /home/engines/scripts/startup/start.sh
        )
      end

    end
  end
end
