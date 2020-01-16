require_relative 'requires'

module Container
  module Docker
    class Seeds < Step

      def content
        %Q(
          RUN \
            cat /home/app//sql/create_tables.sql | sed "/TBLE/s//TABLE/" > /tmp/create_tables.sql.0&& \
            cp /tmp/create_tables.sql.0 /home/app//sql/create_tables.sql&& \
        ) # TODO: more to do here
      end

    end
  end
end
