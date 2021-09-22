module Arenas
  module Terraforming
    include ::Spaces::Streaming

    def init(model); execute(:init, model) ;end
    def plan(model); execute(:plan, model) ;end
    def show(model); execute(:show, model) ;end
    def apply(model); execute(:apply, model) ;end

    protected

    def execute(command, model)
      with_streaming(model, command) do
        identifier.tap { provisioning_for(command, model) }
      end
    end

    def provisioning_for(command, model)
      Dir.chdir(path_for(model)) do
        bridge.send(command, options[command] || {}, config(stream_for(model, command)))
      rescue RubyTerraform::Errors::ExecutionError => e
        raise e
      end
    end

    def config(stream)
      {
        stdout: stdout(stream),
        stderr: stderr(stream),
        logger: logger
      }
    end

    def stdout(stream)
      ->(output) do
        stream.append(output_json_for(output))
        logger.info(output)
      end
    end

    def stderr(stream)
      ->(error) do
        stream.append(error_json_for(error))
        logger.warn(error)
      end
    end

    def output_json_for(output)
      {message: {output: output}}.to_json
    end

    def error_json_for(error)
      {message: {error: error}}.to_json
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
