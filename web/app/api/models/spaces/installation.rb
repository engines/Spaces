module App
  class Api
    module Models
      module Spaces
        class Installation < Models::SpacesItem

          require './ruby/installations/installation'

          def to_h
            {identifier: identifier}.merge(YAML.load(installation.to_yaml).to_h)
          end

          def installation
            Spaces.universe.installations.by(descriptor)
          end

          def create(project)
            installation = ::Installations::Installation.
              new(blueprint: project.blueprint, descriptor: descriptor)
            Spaces.universe.installations.save(installation)
            identifier
          end

          def delete
            Spaces.universe.installations.delete(installation)
          end

        end
      end
    end
  end
end
