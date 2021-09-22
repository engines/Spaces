module Arenas
  module Terraforming

    def init(model, &block); execute(:init, model, &block) ;end
    def plan(model, &block); execute(:plan, model, &block) ;end
    def show(model, &block); execute(:show, model, &block) ;end
    def apply(model, &block); execute(:apply, model, &block) ;end

    protected

    def execute(command, model, &block)
      identifier.tap { provisioning_for(command, model, &block) }
    end

    def provisioning_for(command, model, &block)
      Dir.chdir(path_for(model)) do
        bridge.send(command, options[command] || {}, config(&block))
      rescue RubyTerraform::Errors::ExecutionError => e
        raise e unless block_given?
        yield error_json_for(e.message)
      end
    end

    def config(&block)
      {
        stdout: stdout(&block),
        stderr: stderr(&block),
        logger: logger
      }
    end

    def stdout(&block)
      ->(output) do
        block_given? ?
        yield(output_json_for(output)) :
        logger.info(output)
      end
    end

    def stderr(&block)
      ->(error) do
        block_given? ?
        yield(error_json_for(error)) :
        logger.warn(error)
      end
    end

    def output_json_for(output)
      {output: output}.to_json
    end

    def error_json_for(error)
      {error: error}.to_json
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
