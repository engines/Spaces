require_relative '../releases/release'

module Packing
  class Pack < ::Releases::Release

    delegate(
      [:identifier, :builders, :client] => :resolution
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :keys, :schema_keys
    alias_method :super_memento, :memento

    def repository_name; "#{client.identifier}/#{identifier}" ;end

    def export; output_with(:export) ;end
    def commit; output_with(:commit) ;end
    def memento; output_with(:memento) ;end

    def output_with(method); super_memento.merge(struct_for(builders.all.map(&method))) ;end
    def struct_for(builders); OpenStruct.new(builders: builders) ;end

    def initialize(resolution)
      self.struct = struct_for(resolution.memento.builders)
      self.resolution = resolution
    end

  end
end
