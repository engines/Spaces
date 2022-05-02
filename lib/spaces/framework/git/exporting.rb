module Spaces
  module Git
    module Exporting

      def export(args)
        set_branch
        set_remote
        add
        commit_all(commit_message_for(args))
        push_remote
      end

      def commit_all(message)
        opened.commit_all(message, allow_empty: true)
      end

      def push_remote
        opened.push(remote_name, branch_name, command_options) do |io|
          collect(io)
        end
      rescue git_error
        maybe_stream_export_error
        raise push_failure
      end

      def commit_message_for(args)
        "#{args.dig(:model, :message) || default_commit_message} [BY ENGINES]"
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

    end
  end
end
