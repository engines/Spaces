require_relative '../spaces/model'
require_relative 'infix'

module Texts
  class Text < ::Spaces::Model

    relation_accessor :context
    attr_accessor :content,
      :source_content

    def resolved
      @resolved ||= immutables.zip(infixes.map(&:resolved)).flatten.join
    end

    def infixes
      splits(:odd?).map { |s| infix_class.new(value: s, context: self) }
    end

    def infix_class
      Infix
    end

    def immutables
      splits(:even?)
    end

    def splits(method)
      source_content.split(interpolation_marker).select.with_index { |_, i| i.send(method) }
    end

    def content
      @content ||= resolved
    end

    def interpolation_marker
      '^^'
    end

    def tensor
      context.tensor
    end

    def initialize(source_content:, context:)
      self.context = context
      self.source_content = source_content
    end

  end
end
