module Spaces
  module Git
    module Exporting

      def export(args)
        set_branch
        set_remote
        add
        commit_all(commit_message_for(args))
        push_remote
      rescue git_error => e
        raise_failure_for(e)
      end

      def commit_all(message)
        opened.commit_all(message, allow_empty: true)
      end

      def push_remote
        opened.push(remote_name, branch_name, command_options) { |io| stream.collect(io) }
      end

      def commit_message_for(args)
        "#{args.dig(:model, :message) || default_commit_message} [BY SPACES]"
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

    end
  end
end
