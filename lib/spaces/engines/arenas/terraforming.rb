require 'ruby_terraform'

module Arenas
  module Terraforming

    def init(model); execute(:init, model) ;end
    def plan(model); execute(:plan, model) ;end
    def show(model); execute(:show, model) ;end
    def apply(model); execute(:apply, model) ;end

    protected

    def execute(command, model)
      Dir.chdir(path_for(model)) do
        bridge.send(command, options[command] || {})
      end
    rescue RubyTerraform::Errors::ExecutionError => e
      raise ::Arenas::Errors::ProvisioningError, {execute: command, error: e}
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
