require_relative '../releases/release'

module Packing
  class Pack < ::Releases::Release

    delegate(
      [:identifier, :images, :client, :anchor_descriptors] => :resolution
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :keys, :schema_keys

    def repository_name; "#{client.identifier}/#{identifier}" ;end

    def export; struct_for(images.all.map(&:export)) ;end
    def memento; super.merge(struct_for(images.all.map(&:commit))) ;end

    def struct_for(images); OpenStruct.new(builders: images) ;end

    def initialize(resolution)
      self.struct = struct_for(resolution.memento.images)
      self.resolution = resolution
    end

  end
end
