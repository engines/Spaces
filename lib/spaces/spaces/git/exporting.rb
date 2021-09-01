module Spaces
  module Git
    module Exporting

      def export(**args)
        descriptor.identifier.tap do
          exist? ? export_existing(**args) : export_new(**args)
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
        opened.push(remote_name, branch_name)
      rescue git_error => e
        raise_failure_for(e)
      end

      def redefine_remote
        remove_remote
        add_remote
        fetch
      rescue git_error => e
        raise_failure_for(e)
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

      protected

      def export_existing(**args)
        add
        if opened.status.commitable.any?
          checkout
          commit(**args)
          push_remote
        end
      end

      def export_new(**args)
        init
        add
        commit(**args)
        checkout
        add_remote
        push_remote
      end

      def init
        git.init("#{space.path_for(descriptor)}", log: logger)
      end

    end
  end
end
