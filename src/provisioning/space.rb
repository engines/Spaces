require 'ruby_terraform'
require_relative '../spaces/space'
require_relative 'providers/space'
require_relative 'containers/space'

module Provisioning
  class Space < ::Spaces::Space

    def providers; @providers ||= Providers::Space.new ;end
    def containers; @containers ||= Containers::Space.new ;end

    def save(model)
      model.components.each { |t| save_text(t) }
      model.stanzas.each { |s| _save(s, content: s.declaratives, as: :tf) }
      super
    end

    def init(model); execute(:init, model) ;end
    def plan(model); execute(:plan, model) ;end
    def show(model); execute(:show, model) ;end
    def apply(model); execute(:apply, model) ;end

    protected

    def execute(command, model)
      Dir.chdir(path_for(model))
      bridge.send(command, options[command] || {})
    rescue RubyTerraform::Errors::ExecutionError => e
      warn(error: e, command: command, identifier: model.identifier, verbosity: [:error])
    end

    def bridge; RubyTerraform ;end

    def options
      {
        plan: {
          input: false
        },
        apply: {
          input: false,
          auto_approve: true
        }
      }
    end
  end
end
