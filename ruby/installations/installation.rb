require_relative '../spaces/model'
require_relative 'schema'
require_relative 'collaboration'

module Installations
  class Installation < Collaboration

    delegate(
      installation: :itself,
      [:identifier, :home_app_path] => :descriptor
    )

    alias_accessor :blueprint, :predecessor

    def file_names_for(directory)
      universe.projects.file_names_for(directory, descriptor)
    end

    def initialize(struct: nil, blueprint: nil, descriptor: nil)
      self.blueprint = blueprint
      self.struct = duplicate(struct || blueprint&.struct)
      self.struct.descriptor = self.struct.descriptor&.merge(descriptor&.struct)
    end

    def capture_foreign_keys
      struct.blueprint_identifier ||= blueprint&.identifier
    end

  end
end
