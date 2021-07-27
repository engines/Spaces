require 'git'

module Spaces
  module Git
    module Importing

      def by_import(force: false)
        if space.imported?(descriptor)
          pull_remote if force
        else
          clone_remote
        end

        space.by(descriptor)
      end

      def pull_remote
        opened.pull(remote_name, branch_name)
      rescue git_error => e
        raise_failure_for(e)
      end

      def clone_remote
        git.clone(repository_url, identifier, branch: branch_name, path: space.path, depth: 0)
      rescue git_error => e
        raise_failure_for(e)
      end

    end
  end
end
