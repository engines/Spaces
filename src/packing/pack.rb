require_relative '../releases/release'

module Packing
  class Pack < ::Releases::Release

    delegate(
      [:identifier, :builders] => :resolution
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :memento, :struct

    def initialize(resolution)
      self.struct = OpenStruct.new(builders: resolution.memento.builders)
      self.resolution = resolution
    end

  end
end
