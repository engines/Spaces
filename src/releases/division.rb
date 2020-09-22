require_relative 'transformable'

module Releases
  class Division < Transformable

    attr_accessor :label

    class << self
      def prototype(release:, label:)
        new(release: release, label: label)
      end
    end

    relation_accessor :release

    delegate(context_identifier: :release)

    def initialize(struct: nil, release: nil, label: nil)
      self.release = release
      self.label = label
      self.struct = struct || (release.struct[label] if release) || default
    end

    def to_s; struct ;end

  end
end
