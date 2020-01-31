require_relative '../spaces/model'

module Nodule
  class Nodules < ::Spaces::Model

    def all
      @all ||= struct.map { |s| universe.nodules.by(s) }
    end

    def scripts
      all.map { |a| a.scripts }
    end

  end
end
