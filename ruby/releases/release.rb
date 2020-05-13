require_relative 'collaboration'
require_relative 'stage'

module Releases
  class Release < Collaboration
    relation_accessor :stages

    def divisions
      @divisions ||= [stages&.map(&:divisions), super].flatten.compact
    end

    def stages
      @stages ||= struct.stages&.map { |s| stage_for(s) }
    end

    def stage_for(struct)
      stage_class.new(struct: struct, release: self)
    end

    def stage_class; Stage ;end

    def memento_for(key)
      key == :stages ? stages.map(&:memento) : super
    end

  end
end
