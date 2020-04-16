module App
  class Api
    module Models
      module Spaces
        class Project < Models::SpacesItem

          def to_h
            {identifier: identifier}.merge(YAML.load(blueprint.to_yaml).to_h)
          end

          def blueprint
            Spaces.universe.blueprints.by(descriptor)
          end

          def create
            # TODO: create project
            identifier
          end

          def delete
            Spaces.universe.blueprints.delete(blueprint)
          end

          def installations
            Installations.new(self)
          end

        end
      end
    end
  end
end
