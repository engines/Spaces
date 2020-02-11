require_relative 'product'

module Products
  class Script < Product

    relation_accessor :context
    attr_reader :content

    def content
      [
        header,
        body,
        footer
      ].flatten.compact.join("\n")
    end

    def header
      '#!/bin/sh'
    end

    def body
    end

    def footer
    end

    def path
      "#{build_script_path}/#{file_name}"
    end

    def file_path
      "#{subspace_path}/#{file_name}"
    end

    def file_name
      "#{identifier}.sh"
    end

    def descriptor
      context.descriptor
    end

    def subspace_path
      "#{context.subspace_path}/#{build_script_path}"
    end

    def build_script_path
      context.build_script_path
    end

    def identifier
      context.identifier
    end

    def initialize(context)
      self.context = context
    end

    def method_missing(m, *args, &block)
      if context.respond_to?(m)
        context.send(m, *args, &block)
      else
        super
      end
    end

  end
end
