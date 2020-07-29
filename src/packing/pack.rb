require_relative '../releases/release'

module Packing
  class Pack < ::Releases::Release

    # class << self
    #   def inheritance_paths; __dir__ ;end
    # end

    require_files_in :stanzas

    delegate(
      [:identifier, :builders] => :resolution
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :memento, :struct

    def export
      struct_for(builders.all.map(&:export))
    end

    def commit
      struct_for(builders.all.map(&:commit))
    end

    def initialize(resolution)
      self.struct = struct_for(resolution.memento.builders)
      self.resolution = resolution
    end

    def struct_for(builders)
      OpenStruct.new(
        builders: builders
      )
    end

  end
end
