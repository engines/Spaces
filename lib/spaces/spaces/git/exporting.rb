require 'git'

module Spaces
  module Git
    module Exporting

      def export(**args, &block)
        descriptor.identifier.tap do
          commit(**args, &block)
          push_remote
        end
      end

      def commit(**args, &block)
        opened(&block).tap do |o|
          o.add
          o.commit_all("#{args.dig(:model, :message) || default_commit_message} [BY SPACES]")
          checkout
        end
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
      end

      def default_commit_message; "Exported on #{Time.now}" ;end

    end
  end
end
