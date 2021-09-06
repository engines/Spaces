module Spaces
  module Git
    module Importing
      include Emitting::Lib

      def by_import(force:, &block)
        if space.imported?(descriptor) && remote_current?
          pull_remote(&block)
        else
          space.exist_then_delete(descriptor)
          clone_remote(&block)
        end

        space.by(descriptor)
      end

      private

      def pull_remote(&block)
        emit_to(output_filepath, output_callback(&block)) do |emit|
          emit.info(color.green("\nGit pull start", bold: true))
          emit.info("\nCloning from #{repository_url}(#{branch_name})\n")
          begin
            opened.pull(remote_name, branch_name) do |io|
              io.each_line { |line| emit.info(line) }
            end
          rescue git_error => e
            emit.error(color.red("Git pull failed\n", bold: true))
            raise_failure_for(e)
          end
          emit.info(color.green("Git pull complete\n", bold: true))
        end
      end

      def clone_remote(&block)
        emit_to(output_filepath, output_callback(&block)) do |emit|
          emit.info(color.green("\nGit clone start", bold: true))
          emit.info("\nCloning from #{repository_url}(#{branch_name})\n")
          begin
            git.clone(repository_url, identifier, clone_opts) do |io|
              io.each_line { |line| emit.info(line) }
            end
          rescue git_error => e
            emit.error(color.red("Git clone failed\n", bold: true))
            raise_failure_for(e)
          end
          emit.info(color.green("Git clone complete\n", bold: true))
        end
      end

      def output_filepath
        space.path.join("git.out")
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
