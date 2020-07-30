require_relative '../releases/release'

module Packing
  class Pack < ::Releases::Release

    delegate(
      [:identifier, :builders, :client, :anchor_descriptors] => :resolution
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :keys, :schema_keys

    def repository_name; "#{client.identifier}/#{identifier}" ;end

    def export; struct_for(builders.all.map(&:export)) ;end
    def memento; super.merge(struct_for(builders.all.map(&:commit))) ;end

    def struct_for(builders); OpenStruct.new(builders: builders) ;end

    def initialize(resolution)
      self.struct = struct_for(resolution.memento.builders)
      self.resolution = resolution
    end

  end
end
