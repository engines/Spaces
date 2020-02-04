require_relative 'product'

module Spaces
  class Script < Product

    relation_accessor :context
    attr_reader :content

    def content
      [
        header,
        body
      ].flatten.compact.join("\n")
    end

    def header
      '#!/bin/sh'
    end

    def body
    end

    def descriptor
      context.descriptor
    end

    def initialize(context)
      self.context = context
    end

    def file_path
      "/#{context.path}/#{a.type}/#{a.name}.sh"
    end

  end
end
