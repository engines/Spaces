module Arenas
  module Terraforming
    include ::Spaces::Streaming

    def terraform_init(model); execute(:init, model) ;end
    def terraform_plan(model); execute(:plan, model) ;end
    def terraform_show(model); execute(:show, model) ;end
    def terraform_apply(model); execute(:apply, model) ;end

    protected

    def execute(command, model)
      with_streaming(model, command) do
        identifier.tap { provisioning_for(command, model) }
      end
    end

    def provisioning_for(command, model)
      stream_for(model, command).tap do |stream|
        stream.output("\n") unless command == :init
        Dir.chdir(path_for(model)) do
          bridge.send(command, options[command] || {}, config(out(command, model)))
          stream.output("\n")
        rescue RubyTerraform::Errors::ExecutionError => e
          stream.output("\n")
          stream.error("#{e}\n")
        end
      end
    end

    def config(out)
      {
        stdout: out,
        stderr: out,
        logger: logger
      }
    end

    def out(command, model)
      ->(output) do
        stream_for(model, command).output(output)
        logger.info(output.strip)
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
