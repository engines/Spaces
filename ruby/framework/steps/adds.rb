require_relative 'requires'

module Framework
  class Framework
    class Adds < Container::Docker::Step

      def content
        %Q(
          ADD scripts /scripts
          ADD home home
          ADD spaces home/spaces
          ADD home/start.sh /home/spaces/scripts/startup/start.sh
        )
      end

    end
  end
end
