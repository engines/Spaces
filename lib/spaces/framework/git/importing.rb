module Spaces
  module Git
    module Importing

      def by_import
        if space.imported?(descriptor) && remote_current?
          pull_remote
        else
          space.exist_then_delete(descriptor)
          clone_remote
        end
        space.by(descriptor)
      end

      def pull_remote
        opened.pull(remote_name, branch_name, command_options) do |io|
          collect(io, :import)
        end
      rescue git_error
        stream_import_error
        raise pull_failure
      end

      def clone_remote
        git.clone(repository_url, identifier, clone_options) do |io|
          collect(io, :import)
        end
      rescue git_error
        stream_import_error
        raise clone_failure
      end

      def clone_options
        command_options.merge({
          branch: branch_name,
          path: space.path,
          depth: 0,
        })
      end

    end
  end
end
