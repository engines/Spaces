require_relative '../../../products/script'

module Frameworks
  module Rails5
    module Scripts
      class Bundler < Products::Script

        def body
          %Q(
          echo "Rails.application.routes.default_url_options[:host] = '$fqdn'" >> /home/app/config/environment.rb

          if test -f Gemfile
         	  then
         	  bundle --standalone install
          fi
          )
        end

        def identifier
          'bundler'
        end

      end
    end
  end
end
