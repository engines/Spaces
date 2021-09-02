module Spaces
  module Git
    module Exporting

      def export(**args)
        descriptor.identifier.tap do
          init unless exist?
          export_repo(**args)
        rescue git_error => e
          raise_failure_for(e)
        end
      end

      def commit(**args)
        opened.commit_all("#{args.dig(:model, :message) || default_commit_message} [BY SPACES]")
      rescue git_error => e
        raise_failure_for(e)
      end

      def push_remote
        redefine_remote unless remote_current?
        opened.push(remote_name, branch_name, force: true)
      rescue git_error => e
        raise_failure_for(e)
      end

      def redefine_remote
        remove_remote
        add_remote
        # fetch
      rescue git_error => e
        raise_failure_for(e)
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

      protected

      def export_repo(**args)
        set_branch
        add
        if opened.status.commitable.any?
          commit(**args)
        end
        push_remote
      end

      def init
        git.init("#{space.path_for(descriptor)}", log: logger)
      end

    end
  end
end
