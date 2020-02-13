require_relative 'requires'

module Docker
  module Files
    module Steps
      class Seeds < Step

        def content
          #FixME this is not the seeds script
          %Q(
          RUN \
            cat #{home_app_path}//sql/create_tables.sql | sed "/TBLE/s//TABLE/" > /tmp/create_tables.sql.0&& \
            cp /tmp/create_tables.sql.0 #{home_app_path}//sql/create_tables.sql&& \
          ) # TODO: more to do here
        end

       def home_app_path
         context.image.home_app_path
       end
      end
    end
  end
end
