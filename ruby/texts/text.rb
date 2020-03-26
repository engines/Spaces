require_relative '../spaces/model'
require_relative 'infix'

module Texts
  class Text < ::Spaces::Model

    relation_accessor :context
    attr_accessor :product,
      :source

    def resolved
      @resolved ||= contains_interpolation? ? resolve : source
    end

    def resolve
      immutables.zip(infixes.map(&:resolved)).flatten.join
    end

    def contains_interpolation?
      source.include?(interpolation_marker)
    rescue NoMethodError
      false
    rescue

    end

    def infixes
      splits(:odd?).map { |s| infix_class.new(value: s, text: self) }
    end

    def infix_class
      Infix
    end

    def immutables
      splits(:even?)
    end

    def splits(method)
      source.split(interpolation_marker).select.with_index { |_, i| i.send(method) }
    end

    def product
      @product ||= resolved
    end

    def interpolation_marker
      '^^'
    end

    def installation
      context.installation
    end

    def initialize(source:, context:)
      self.context = context
      self.source = source
    end

  end
end
