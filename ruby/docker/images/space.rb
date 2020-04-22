require 'docker-api'
require_relative '../../spaces/space'
require_relative '../monkeys/image'
require_relative '../files/file'

module Docker
  module Images
    class Space < ::Spaces::Space

      relation_accessor :abstract

      delegate(
        path_for: :abstract,
        [:all, :get] => :bridge
      )

      def pull(identifier)
        bridge.create(fromImage: identifier)
      end

      alias_method :import, :pull

      def from_subject(subject)
        bridge.build_from_dir(path_for(subject), options_for(subject), connection, default_header) do |k|
          pp "#{k}"
        end.tap do |i|
          i.tag(repo: subject.identifier)
        end
      end

      def from_tar(path)
        bridge.build_from_tar(file_class.open("#{path_for(subject)}.tar", 'r'))
      end

      def options_for(subject)
        default_options
      end

      def default_options
        {
          dockerfile: file_class.qualifier,
          force: true,
          rm: true
        }
      end

      def default_header
        {
          'Content-Type': 'application/tar',
          'Accept-Encoding': 'gzip',
          Accept: '*/*'
          # 'Content-Length': "#{File.size(?)}"
        }
      end

      def initialize(abstract)
        self.abstract = abstract
      end

      def connection
        Docker.connection
      end

      def bridge
        Docker::Image
      end

      def file_class
        Files::File
      end

    end
  end
end
