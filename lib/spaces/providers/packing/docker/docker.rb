require_relative 'patch/image'

module Providers
  class Docker < ::ProviderAspects::Provider
    extend Docker
    include ::Spaces::Streaming

    ::Docker.options[:read_timeout] = 1000
    ::Docker.options[:write_timeout] = 1000

    alias_method :pack, :emission

    delegate(
      [:connection, :version, :info, :default_socket_url] => :klass,
      [:image_name, :output_name] => :pack,
      [:all, :get, :prune] => :bridge
    )

    def save
      artifact_path.write(artifact)
    end

    def artifact
      pack.artifact.values.join("\n")
    end

    def create
      bridge.create(name: image_name)
    end

    def pull
      bridge.create(fromImage: image_name)
    end

    alias_method :import, :pull

    def all(options = {})
      bridge.all(options.reverse_merge(all: true))
    end

    def build
      with_streaming(pack, :build) do
        space.copy_auxiliaries_for(pack)
        build_from_pack
        space.remove_auxiliaries_for(pack)
      end
    end

    alias_method :commit, :build

    def build_from_pack
      bridge
      .build_from_dir("#{path_for(pack)}") { |io| collect(io) }
      .tap { |image| tag_latest(image) }
    end

    def collect(io)
      stream_on(:build).collect(io, &:itself)
    end

    def stream_on(identifier)
      stream_for(pack, identifier)
    end

    def tag_latest(image)
      image.tag('repo' => pack.output_name, 'force' => true, 'tag' => 'latest')
    end

    # def from_pack
    #   bridge.build_from_dir("#{path_for(pack)}", options, connection, default_header) do |k|
    #     pp "#{k}"
    #   end.tap do |i|
    #     i.tag(repo: pack.output_name)
    #   end
    # end
    #
    # def from_tar
    #   bridge.build_from_tar(Pathname.new("#{path_for(pack)}.tar").read)
    # end

    def artifact_path; path_for(pack).join(artifact_filename) ;end

    # def options; default_options ;end
    def bridge; ::Docker::Image ;end
    def file_class; Files::File ;end

    # def default_options
    #   {
    #     dockerfile: file_class.qualifier,
    #     force: true,
    #     rm: true
    #   }
    # end

    def artifact_filename; 'Dockerfile' ;end

    # def default_header
    #   {
    #     'Content-Type': 'application/tar',
    #     'Accept-Encoding': 'gzip',
    #     Accept: '*/*'
    #     # 'Content-Length': "#{::File.size(?)}"
    #   }
    # end

  end
end
