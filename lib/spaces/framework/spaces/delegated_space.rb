require_relative 'space'

module Spaces
  class DelegatedSpace < Space

    def identifiers = summaries.map(&:identifier)

    def all
      @all ||= interfaces.map(&:all).flatten
    end

    def interfaces = []

  end
end
