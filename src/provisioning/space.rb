require 'ruby_terraform'
require_relative '../spaces/space'
require_relative 'providers/space'

module Provisioning
  class Space < ::Spaces::Space

    def providers
      @providers ||= Providers::Space.new
    end

    def save(model)
      model.components.each { |t| save_text(t) }
      model.stanzas.each { |s| _save(s, content: s.declaratives, as: :tf) }
    end

    def init(model); execute(:init, model) ;end
    def plan(model); execute(:plan, model) ;end
    def apply(model); execute(:apply, model) ;end

    protected

    def execute(command, model)
      Dir.chdir(path_for(model))
      bridge.send(command)
    rescue RubyTerraform::Errors::ExecutionError => e
      warn(error: e, descriptor: model.descriptor, verbosity: [:error])
    end

    def bridge; RubyTerraform ;end
  end
end
