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
      filepath = dir.join("#{command}.log")
      FileUtils.touch(filepath)
      Emitting::Output.new(filepath, &block).follow do |output|
        Dir.chdir(dir) do
          # TODO: USE bridge.send(command, options[command] || {})
          begin
            Object
            .const_get("RubyTerraform::Commands::#{command.camelize}")
            .new(stdout: output, stderr: output)
            .execute
          rescue RubyTerraform::Errors::ExecutionError => e
            output.error("\n\033[1;31mTerraform #{command} error.\n\033[0;31m#{e}\033[0m")
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
