module App
  class Api
    module Models
      module Spaces
        class Installations < Models::SpacesCollection

          def to_a
            Spaces.universe.installations.identifiers.sort
          end

          def by(identifier)
            Installation.new(identifier)
          end

          def create(project, installation)
            by(installation[:identifier]).create(project)
          end

        end
      end
    end
  end
end
