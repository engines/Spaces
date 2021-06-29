require 'docker'
require_relative 'patch/image'

module Providers
  class Docker < ::ProviderAspects::Provider
    extend Docker

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

    def build
      space.copy_auxiliaries_for(pack)
      i = bridge.build_from_dir(path_for(pack).to_path)
      i.tag('repo' => pack.output_name, 'force' => true, 'tag' => 'latest')
      space.remove_auxiliaries_for(pack)
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
