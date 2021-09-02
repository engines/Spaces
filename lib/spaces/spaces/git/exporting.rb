module Spaces
  module Git
    module Exporting

      def export(**args)
        export_repo(**args)
        descriptor.identifier
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

      def redefine_remote
        remove_remote
        add_remote
      rescue git_error => e
        raise_failure_for(e)
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

      protected

      def export_repo(**args)
        set_branch
        set_remote
        add
        commit(**args) # if opened.status.commitable.any?
        push_remote
      end



      # def setup_repo
      # echo "" >> README.md
      # add
      # end

      # def init
      #
      #   git.init("#{space.path_for(descriptor)}", log: logger)
      #
      # end

    end
  end
end
