require_relative '../spaces/model'
require_relative 'active_schema'
require_relative 'collaboration'

module Installations
  class Installation < Collaboration

    delegate(
      installation: :itself,
      [:identifier, :home_app_path] => :descriptor
    )

    relation_accessor :blueprint

    def product
      struct.tap do |s|
        mutable_divisions.each do |k|
          if c = collaborators[k]
            s[k] = c.product
          end
        end
      end
    end

    def file_names_for(directory)
      universe.blueprints.file_names_for(directory, descriptor)
    end

    def initialize(struct: nil, blueprint: nil, descriptor: nil)
      self.blueprint = blueprint
      self.struct = duplicate(struct || blueprint&.struct)
      self.struct.descriptor = self.struct.descriptor&.merge(descriptor&.struct)
    end

    def capture_foreign_keys
      struct.blueprint_identifier ||= blueprint&.identifier
    end

    def schema_class
      ActiveSchema
    end

  end
end
