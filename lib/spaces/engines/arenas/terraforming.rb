require 'ruby_terraform'

module Arenas
  module Terraforming

    def init(model, &block); execute(:init, model, &block) ;end
    def plan(model, &block); execute(:plan, model, &block) ;end
    def show(model, &block); execute(:show, model, &block) ;end
    def apply(model, &block); execute(:apply, model, &block) ;end

    protected

    def execute(command, model, &block)
      dir = path_for(model)
      filepath = dir.join("build.log")
      FileUtils.touch(filepath)
      begin
        Emitting::Output.new(filepath, &block).follow do |output|
          Dir.chdir(dir) do
            # TODO: USE bridge.send(command, options[command] || {})
            begin
              Object
              .const_get("RubyTerraform::Commands::#{command.camelize}")
              .new(stdout: output, stderr: output)
              .execute
            rescue RubyTerraform::Errors::ExecutionError => e
              raise ::Arenas::Errors::ProvisioningError, {execute: command, error: e}
            end
          end
        end
      end
      command
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
