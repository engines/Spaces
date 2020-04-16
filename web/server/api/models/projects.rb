module Server
  class Api
    module Models
      class Projects

        def initialize(spaces)
          @spaces = spaces
        end

        attr_accessor :spaces

        def list
          spaces.universe.projects.identifiers
        end

        def to_json
          list.to_json
        end

        def find(identifier)
          Project.new spaces, identifier
        end

      end
    end
  end
end
