module Server
  class Api
    module Models
      module Spaces

        require "./ruby/universal/space"

        def self.projects
          Projects.new self
          # universe.projects.identifiers.map do |identifier|
          #   Project.new self, identifier
          # end
        end

        # def self.installations
        #   universe.installations.identifiers.map do |identifier|
        #     Installation.new self, identifier
        #   end
        # end

        def self.universe
          @universe ||= Universal::Space.new
        end

      end
    end
  end
end
