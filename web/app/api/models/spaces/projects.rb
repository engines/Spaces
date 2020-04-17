module App
  class Api
    module Models
      module Spaces
        class Projects < Models::SpacesCollection

          def to_a
            Spaces.universe.projects.identifiers.sort
          end

          def by(identifier)
            Project.new(identifier)
          end

          def create(project)
            by(project[:identifier]).create
          end

        end
      end
    end
  end
end
