require_relative 'requires'

module Docker
  class File < ::Spaces::Product
    class Installs < Step

      def content
        %Q(
          WORKDIR /home/
          RUN \
            bash /home/setup.sh
        )
      end

    end
  end
end
