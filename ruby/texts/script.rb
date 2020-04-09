require_relative '../spaces/model'

module Texts
  class Script < ::Spaces::Model

    relation_accessor :context
    attr_reader :product

    delegate([:path, :home_app_path, :identifier, :context_identifier] => :context)

    def product
      [
        header,
        body,
        footer
      ].flatten.compact.join("\n")
    end

    def header
      '#!/bin/sh'
    end

    def body; end

    def footer; end

    def permission
      0755
    end

    def echo(string)
    %Q(
    echo "#{string}"
    #{string}
    )
    end

    def full_path
      "#{path}/#{file_name}"
    end

    def file_name
      "#{identifier}.sh"
    end

    def subpath
      "#{context.subpath}/#{path}"
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
