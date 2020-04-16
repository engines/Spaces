module Server
  class Api
    module Models

      Dir.glob( [ File.dirname(__FILE__) + "/models/**/*.rb" ] ).each { |file|
        require file
      }

    end
  end
end
