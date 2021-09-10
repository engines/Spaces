module Spaces
  module Git
    module Exporting
      include Spaces::Filing

      def export(args, filing: false, &block)
        filing ?
        export_with_output(args) :
        export_git_repo(args, &block)
        return descriptor.identifier
      # rescue git_error => e
      #   raise_failure_for(e)
      end

      def export_with_output(args)
        output_to_file(export_out_path(args),
          content_lambda: ->(out) { export_git_repo(args) { |output| out.call(output) } },
          rescue_exceptions: rescue_exceptions
        )
      end

      def export_git_repo(args, &block)
        begin
          export_procedure_for(args) do |output|
            yield "#{{output: output}.to_json}\n" if block_given?
          end
          yield "#{{output: "\n"}.to_json}\n" if block_given?
        rescue git_error => e
          yield "#{{output: "\n"}.to_json}\n" if block_given?
          yield "#{{error: "Failed to export #{args[:identifier]}"}.to_json}\n" if block_given?
        end
      end

      def export_procedure_for(args, &block)
        set_branch
        set_remote
        add
        commit(commit_message_for(args), &block)
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

      def commit_message_for(args)
        "#{args.dig(:model, :message) || default_commit_message} [BY SPACES]"
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

      def export_out_path(args)
        universe.send(args[:space]).path.join('export.out')
      end

    end
  end
end
