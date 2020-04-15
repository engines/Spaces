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
      self.descriptor = descriptor
      self.struct = struct || blueprint&.struct
    end

  end
end
