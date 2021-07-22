require 'git'

module Spaces
  module Git
    module Exporting

      def export(**args)
        descriptor.identifier.tap do
          commit(**args)
          push_remote
        end
      end

      def push_remote
        opened.push(:origin, branch_name)
      rescue git_error => e
        raise_failure_for(e)
      end

      def commit(message: nil)
        opened.commit_all("#{message || default_commit_message} [BY SPACES]")
      rescue git_error => e
        raise_failure_for(e)
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

    end
  end
end
