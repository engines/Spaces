require 'ruby_terraform'

module Arenas
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Arena
      end
    end

    def save(model)
      super.tap do
        _save(model, content: model.stanzas_content, as: :tf)
      end
    end

    def save_provisions(provisions)
      _save(provisions, content: provisions.stanzas_content, as: :tf)
    end

    def path_for(model)
      path.join(model.arena.context_identifier)
    end

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
