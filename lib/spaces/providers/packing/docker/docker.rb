require 'docker'
require_relative 'patch/image'

module Providers
  class Docker < ::ProviderAspects::Provider
    extend Docker

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

    def build(&block)
      dir = path_for(pack)
      filepath = dir.join("build.log")
      FileUtils.touch(filepath)
      space.copy_auxiliaries_for(pack)
      File.open(filepath, 'w') do |file|
        build_from_dir(dir, file, &block)
      end
      space.remove_auxiliaries_for(pack)
    end

    def build_from_dir(dir, file, &block)
      begin
        i = bridge.build_from_dir(dir.to_path) do |chunk|
          emit(file, output_for(chunk), &block)
        end
        i.tag('repo' => pack.output_name, 'force' => true, 'tag' => 'latest')
      rescue StandardError => e
        emit(file, "\n\033[1;31mServer exception.\n\033[0;31m#{e}\033[0m", &block)
      end
    end

    def emit(file, output)
      output.split("\n").each do |line|
        file.write "#{line}\n"
        yield line if block_given?
      end
    end

    def output_for(chunk)
      data = JSON.parse(chunk, symbolize_names: true)
      if data[:stream]
        data[:stream]
      elsif data[:errorDetail]
        message = (data[:errorDetail] || {})[:message] || 'No error message.'
        "\n\033[1;31mBuild error.\n\033[0;31m#{message}\033[0m"
      end
    end

    alias_method :commit, :build

    def from_pack
      bridge.build_from_dir("#{path_for(pack)}", options, connection, default_header) do |k|
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
