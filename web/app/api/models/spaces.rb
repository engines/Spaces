module App
  class Api
    module Models
      module Spaces

        require "./ruby/universal/space"

        def self.projects
          Projects.new
        end

        def self.installations
          Installations.new
        end

        def self.universe
          @universe ||= Universal::Space.new
        end

      end
    end
  end
end
