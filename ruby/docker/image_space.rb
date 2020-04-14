require 'docker-api'
require_relative '../spaces/space'
require_relative 'files/file'

module Docker
  class ImageSpace < ::Spaces::Space

    def pull(identifier)
      create('fromImage' => identifier)
    end

    def from_directory(path, &block)
      bridge.build_from_dir(path, { 'dockerfile' => Files::File.identifier }, &block)
    end

    def from_tar(path)
      bridge.build_from_tar(File.open("#{path}.tar", 'r'))
    end

    def bridge
      Docker::Image
    end

  end
end
