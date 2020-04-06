require_relative '../spaces/model'

module Texts
  class Script < ::Spaces::Model

    relation_accessor :context
    attr_reader :product

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

    def permission
     0755  
    end
    
    def body
    end

    def footer
    end

    def echo(string)
    %Q(
    echo "#{string}"
    #{string}
    )
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

    def home_app_path
      context.home_app_path
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
