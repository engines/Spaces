module Spaces
  module Git
    module Importing

      def by_import(force:, &block)
        if space.imported?(descriptor) && remote_current?
          pull_remote(&block) if force
        else
          space.exist_then_delete(descriptor)
          clone_remote(&block)
        end

        space.by(descriptor)
      end

      def pull_remote
        opened.pull(remote_name, branch_name)
      rescue git_error => e
        raise_failure_for(e)
      end

      def clone_remote(&block)
        filepath = space.path.join("git.log")
        FileUtils.touch(filepath)
        file = File.open(filepath, 'w')
        begin
          Emitting::Logger.new(file, &block).follow do |logger|
            git.clone(repository_url, identifier, branch: branch_name, path: space.path, depth: 0, logger: logger)
          rescue git_error => e
            raise_failure_for(e)
          end
        ensure
          file.close
        end
      end
    end
  end
end
