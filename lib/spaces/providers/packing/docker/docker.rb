require 'docker'
require_relative 'patch/image'

module Providers
  class Docker < ::ProviderAspects::Provider
    extend Docker

    ::Docker.options[:read_timeout] = 1000
    ::Docker.options[:write_timeout] = 1000

    alias pack emission

    delegate(
      %i[connection version info default_socket_url] => :klass,
      %i[image_name output_name] => :pack,
      %i[all get prune] => :bridge
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

    alias import pull

    def all(options = {})
      bridge.all(options.reverse_merge(all: true))
    end

    def build
      space.copy_auxiliaries_for(pack)
      i = bridge.build_from_dir(path_for(pack).to_path) do |chunk|
        puts chunk
      end
      i.tag('repo' => pack.output_name, 'force' => true, 'tag' => 'latest')
      space.remove_auxiliaries_for(pack)
    end

    alias commit build

    def from_pack
      bridge.build_from_dir(path_for(pack).to_s, options, connection, default_header) do |k|
        pp k.to_s
      end.tap do |i|
        i.tag(repo: pack.output_name)
      end
    end

    def from_tar
      bridge.build_from_tar(Pathname.new("#{path_for(pack)}.tar").read)
    end

    def artifact_path
      path_for(pack).join(artifact_filename)
    end

    def options
      default_options
    end

    def bridge
      ::Docker::Image
    end

    def file_class
      Files::File
    end

    def default_options
      {
        dockerfile: file_class.qualifier,
        force: true,
        rm: true
      }
    end

    def artifact_filename
      'Dockerfile'
    end

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
