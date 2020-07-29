require_relative '../releases/release'

module Packing
  class Pack < ::Releases::Release

    delegate(
      [:identifier, :builders] => :resolution
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :keys, :schema_keys

    def export
      memento.merge(struct_for(builders.all.map(&:export)))
    end

    def commit
      memento.merge(struct_for(builders.all.map(&:commit)))
    end

    def memento
      super.merge(struct_for(builders.all.map(&:memento)))
    end

    def initialize(resolution)
      self.struct = OpenStruct.new(builders: resolution.memento.builders)
      self.resolution = resolution
    end

    def struct_for(builders)
      OpenStruct.new(builders: builders)
    end

  end
end
