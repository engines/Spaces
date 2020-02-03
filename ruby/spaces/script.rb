require_relative 'product'

module Spaces
  class Script < Product

    relation_accessor :context
    attr_reader :content

    def content
      [
        header,
        body,
        final
      ].flatten.compact.join("\n")
    end

    def header
      '#!/bin/sh'
    end
    
    def final
    end

    def body
    end

    def descriptor
      context.descriptor
    end

    def initialize(context)
      self.context = context
    end

  end
end
