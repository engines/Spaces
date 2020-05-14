require_relative '../spaces/model'

module Texts
  class Script < ::Spaces::Model

    relation_accessor :context
    attr_reader :text

    delegate([:release_path, :home_app_path, :identifier, :context_identifier] => :context)

    def instructions
      [
        header,
        body,
        footer
      ].flatten.compact.join("\n")
    end

    alias_method :content, :instructions

    def header; '#!/bin/sh' ;end
    def body ;end
    def footer ;end
    def permission; 0755 ;end

    def echo(string)
    %Q(
    echo "#{string}"
    #{string}
    )
    end

    def full_path; "/#{release_path}/#{file_name}" ;end
    def file_name; "#{identifier}.sh" ;end
    def subpath; "#{context.subpath}/#{release_path}" ;end

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
