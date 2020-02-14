require_relative '../../../collaborators/script_once'

module Frameworks
  module Rails5
    module Scripts
      class Bundler < Collaborators::ScriptOnce

        def body
          %Q(
          echo "Rails.application.routes.default_url_options[:host] = '$fqdn'" >> #{home_app_path}/config/environment.rb

          if test -f Gemfile
         	  then
         	  bundle --standalone install
          fi
          )
        end

      end
    end
  end
end
