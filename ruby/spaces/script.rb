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

    def path
      "#{image_space_path}/#{file_name}"
    end

    def file_path
      "#{subspace_path}/#{file_name}"
    end

    def image_space_path
      context.image_space_path
    end

    def subspace_path
      context.subspace_path
    end

    def file_name
      "#{identifier}.sh"
    end

    def identifier
      context.identifier
    end

    def initialize(context)
      self.context = context
    end

  end
end
