module App
  class Api
    module Models
      module Spaces
        class Project
          class Installations < SpacesCollection

            def initialize(project)
              @project = project
            end

            attr_accessor :project

            def to_a
              Spaces.universe.installations.descriptors.select do |d|
                d.repository == project.blueprint.descriptor.repository
              end.sort_by do |d|
                d.identifier
              end.map &:to_s
            end

            def create(installation)
              Spaces::Installations.new.
                create(project, installation)
            end

          end
        end
      end
    end
  end
end
