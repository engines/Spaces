module Spaces
  module Git
    module Importing

      def by_import(&block)
        begin
          clone_or_pull(&block)
        rescue git_error => e
          raise_failure_for(e) unless block_given?
          yield(error_json_for("Failed to import\n#{e}"))
        end
        space.by(descriptor)
      end

      private

      def clone_or_pull(&block)
        if space.imported?(descriptor) && remote_current?
          pull_remote(&block)
        else
          space.exist_then_delete(descriptor)
          clone_remote(&block)
        end
      end


      def pull_remote(&block)
        opened.pull(remote_name, branch_name) { |io| outputting(io, &block) }
      rescue git_error => e
        raise_failure_for(e) unless block_given?
        yield(error_json_for(e))
      end

      def clone_remote(&block)
        git.clone(repository_url, identifier, clone_opts) { |io| outputting(io, &block) }
      rescue git_error => e
        raise_failure_for(e) unless block_given?
        yield(error_json_for(e))
      end

      def clone_opts
        {
          branch: branch_name,
          path: space.path,
          logger: logger,
          depth: 0,
          verbose: true,
          progress: true,
        }
      end

    end
  end
end
