require 'docker'
require_relative 'patch/image'

module Providers
  class Docker < ::ProviderAspects::Provider
    extend Docker
    include Spaces::Emitting::Lib

    ::Docker.options[:read_timeout] = 1000
    ::Docker.options[:write_timeout] = 1000

    alias_method :pack, :emission

    delegate(
      [:connection, :version, :info, :default_socket_url] => :klass,
      [:image_name, :output_name] => :pack,
      [:all, :get, :prune] => :bridge
    )

    def save
      artifact_path.write(pack.artifact.values.join("\n"))
    end

    def create
      bridge.create(name: image_name)
    end

    # def create
    #   bridge.create(
    #     name: image_name,
    #     Image: image_name,
    #     Volumes: { image_name => {} }
    #   )
    # end

    def pull
      bridge.create(fromImage: image_name)
    end

    alias_method :import, :pull

    def all(options = {})
      bridge.all(options.reverse_merge(all: true))
    end

    def dir
      path_for(pack)
    end

    def output_filepath
      dir.join("build.out")
    end

    def build(&block)
      space.copy_auxiliaries_for(pack)
      # _build(&block)
      i = bridge.build_from_dir(dir.to_path)
      i.tag('repo' => pack.output_name, 'force' => true, 'tag' => 'latest')
      space.remove_auxiliaries_for(pack)
    end

    def _build(&block)
      emit_to(output_filepath, output_callback(&block)) do |emit|
        errors = 0
        emit.info(color.green("\nDocker build start", bold: true))
        i = bridge.build_from_dir(dir.to_path) do |chunk|
          data = JSON.parse(chunk, symbolize_names: true)
          if data[:stream]
            emit.info(data[:stream])
          elsif data[:errorDetail]
            errors += 1
            message = (data[:errorDetail] || {})[:message] || 'No error message.'
            emit.error(color.red("\nBuild error\n", bold: true))
            emit.error(color.red("#{message}\n"))
          end
        end
        i.tag('repo' => pack.output_name, 'force' => true, 'tag' => 'latest')
        if errors.zero?
          emit.info(color.green("Docker build complete\n", bold: true))
        else
          emit.info(color.red("Docker build complete ", bold: true))
          emit.info(color.red("#{errors} error#{errors == 1 ? 's' : ''}\n"))
        end
      end
    end

    alias_method :commit, :build

    def from_pack
      bridge.build_from_dir("#{path_for(pack)}", options, connection, default_header) do |k|
        # TODO: Does this output need to be logged, or sent to a streaming callback?
        pp "#{k}"
      end.tap do |i|
        i.tag(repo: pack.output_name)
      end
    end

    def from_tar
      bridge.build_from_tar(Pathname.new("#{path_for(pack)}.tar").read)
    end

    def artifact_path; path_for(pack).join(artifact_filename) ;end

    def options; default_options ;end
    def bridge; ::Docker::Image ;end
    def file_class; Files::File ;end

    def default_options
      {
        dockerfile: file_class.qualifier,
        force: true,
        rm: true
      }
    end

    def artifact_filename; 'Dockerfile' ;end

    def default_header
      {
        'Content-Type': 'application/tar',
        'Accept-Encoding': 'gzip',
        Accept: '*/*'
        # 'Content-Length': "#{::File.size(?)}"
      }
    end
  end
end
