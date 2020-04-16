module Server
  class Api
    module Models
      class Project

        def initialize(spaces, identifier)
          @spaces = spaces
          @identifier = identifier
        end

        attr_accessor :identifier

        def to_json
          {
            identifier: identifier,
            stuff: project.to_yaml
          }
        end

        def project
          spaces.universe.blueprints.by( descriptor )
        end

        def descriptor
          Spaces::Descriptor.new identifier: identifier
        end

      end
    end
  end
end
