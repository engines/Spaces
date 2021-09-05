module Spaces
  module Git
    module Importing
      include Spaces::Filing

      def by_import(force: true, thread: true)
        # TODO: Pass :force option from client.
        clear_file(import_output_filepath)
        descriptor.tap do
          thread ?
          Thread.new { import_remote(thread: thread) } :
          import_remote
        end
      end

      private

      def import_remote(opts={})
        if space.imported?(descriptor) && remote_current?
          file_output_from(:pull_remote, import_output_filepath, opts)
        else
          space.exist_then_delete(descriptor)
          file_output_from(:clone_remote, import_output_filepath, opts)
        end
      end

      def pull_remote
        opened.pull(remote_name, branch_name) do |io|
          io.each_line { |line| yield line }
        end
      end

      def clone_remote
        git.clone(repository_url, identifier, clone_opts) do |io|
          io.each_line { |line| yield line }
        end
      end

      def import_output_filepath
        space.path.join("import.out")
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
