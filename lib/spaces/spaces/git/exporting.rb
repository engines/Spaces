module Spaces
  module Git
    module Exporting

      def export(args, &block)
        set_branch
        set_remote
        add
        commit_all(commit_message_for(args), &block)
        push_remote(&block)
      rescue git_error => e
        raise_failure_for(e) unless block_given?
        yield(error_json_for("Failed to export\n#{e}"))
      end

      protected

      def commit_all(message)
        opened.commit_all(message, allow_empty: true)
      end

      def push_remote(&block)
        opened.push(remote_name, branch_name) { |io| output_for(io, &block) }
      end

      def commit_message_for(args)
        "#{args.dig(:model, :message) || default_commit_message} [BY SPACES]"
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

    end
  end
end
