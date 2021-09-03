module Spaces
  module Git
    module Exporting

      def export(**args)
        descriptor.identifier.tap do
          set_branch
          set_remote
          add
          commit(**args)
          push_remote
        end
      rescue git_error => e
        raise_failure_for(e)
      end

      def commit(**args)
        opened.commit_all("#{args.dig(:model, :message) || default_commit_message} [BY SPACES]", allow_empty: true)
      rescue git_error => e
        raise_failure_for(e)
      end

      def push_remote
        opened.push(remote_name, branch_name, force: true)
      rescue git_error => e
        raise_failure_for(e)
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

    end
  end
end
