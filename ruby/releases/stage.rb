require_relative 'collaboration'

module Releases
  class Stage < Collaboration

    relation_accessor :release

    delegate([:identifier, :home_app_path] => :release)

    def initialize(struct:, release:)
      self.release = release
      self.struct = duplicate(struct)
    end

    def method_missing(m, *args, &block)
      release.send(m, *args, &block) || super
    end

  end
end
