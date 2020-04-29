require 'docker-api'
require_relative '../space'
require_relative '../monkeys/image'
require_relative '../files/file'

module Docker
  module Images
    class Space < ::Docker::Space

      relation_accessor :abstract

      delegate(path_for: :abstract)

      def pull(identifier)
        bridge.create(fromImage: identifier)
      end

      alias_method :import, :pull

      def all(options = {})
        bridge.all(options.reverse_merge(all: true))
      end

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

      define_method (:options_for) { |subject| default_options }
      define_method (:bridge) { Docker::Image }
      define_method (:file_class) { Files::File }

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

    end
  end
end
