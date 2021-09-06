require 'ruby_terraform'

module Arenas
  module Terraforming
    include Spaces::Filing

    def init(model, &block); execute(:init, model, &block) ;end
    def plan(model, &block); execute(:plan, model, &block) ;end
    def show(model, &block); execute(:show, model, &block) ;end
    def apply(model, &block); execute(:apply, model, &block) ;end

    protected

    def command_out_path(command, model)
      path_for(model).join("#{command}.out")
    end

    # TODO: The :thread option should default to false and be set by controller.
    def execute(command, model, thread: true)
      identifier.tap do
        thread ?
        Thread.new { execute_with_output(command, model, rescue_exceptions: true) } :
        execute_with_output(command, model)
      end
    end

    def execute_with_output(command, model, rescue_exceptions: false)
      output_to_file(command_out_path(command, model),
        content_lambda: ->(out) { perform_command_for(command, model) { |output| out.call(output) } },
        rescue_exceptions: rescue_exceptions
      )
    end

    def perform_command_for(command, model)
      Dir.chdir(path_for(model)) do
        begin
          Object.const_get("RubyTerraform::Commands::#{command.camelize}").new(
            stdout: Proxy::Stdout.new(command_out_path(command, model)),
            stderr: Proxy::Stdout.new(command_out_path(command, model)),
            logger: logger
          ).execute
        rescue RubyTerraform::Errors::ExecutionError => e
          yield("#{{error: e.message}.to_json}\n")
        end
      end
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
