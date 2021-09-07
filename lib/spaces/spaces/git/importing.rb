module Spaces
  module Git
    module Importing

      def by_import(force:, &block)
        if space.imported?(descriptor) && remote_current?
          pull_remote(&block)
        else
          space.exist_then_delete(descriptor)
          clone_remote(&block)
        end
        yield "\n" if block_given?
        space.by(descriptor)
      end

      private

      def pull_remote
        opened.pull(remote_name, branch_name) do |io|
          io.each_line { |output| yield output if block_given?}
        end
      end

      def clone_remote
        git.clone(repository_url, identifier, clone_opts) do |io|
          io.each_line { |output| yield output if block_given?}
        end
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
