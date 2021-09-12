module Spaces
  module Git
    module Exporting
      include Spaces::Filing

      def export(options, thread: true)
        descriptor.identifier.tap do
          thread ?
          Thread.new { export_with_output(options, rescue_exceptions: true) } :
          export_with_output(options)
        end
      rescue git_error => e
        raise_failure_for(e)
      end

      def export_with_output(options, rescue_exceptions: false)
        output_to_file(export_out_path(options),
          content_lambda: ->(out) { export_git_repo(options) { |output| out.call(output) } },
          rescue_exceptions: rescue_exceptions
        )
      end

      def export_git_repo(options, &block)
        logger.info("Git emport...")
        begin
          export_procedure_for(options) do |output|
            logger.info("> #{output.strip}")
            yield "#{{output: output}.to_json}\n"
          end
          yield "#{{output: "\n"}.to_json}\n"
        rescue git_error => e
          yield "#{{output: "\n"}.to_json}\n"
          yield "#{{error: "Failed to export #{options[:identifier]})"}.to_json}\n"
        end
      end

      def export_procedure_for(options, &block)
        set_branch
        set_remote
        add
        commit(commit_message_for(options), &block)
        push_remote(&block)
      end

      def commit(message)
        opened.commit_all(message, allow_empty: true) do |io|
          io.each_line { |output| yield output if block_given? }
        end
      end

      def push_remote
        opened.push(remote_name, branch_name, force: true) do |io|
          io.each_line { |output| yield output if block_given? }
        end
      end

      def commit_message_for(options)
        "#{options.dig(:model, :message) || default_commit_message} [BY SPACES]"
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

      def export_out_path(options)
        universe.send(options[:space]).path.join('export.out')
      end

    end
  end
end
