require 'docker-api'
require_relative '../../spaces/space'
require_relative '../files/file'

module Docker
  module Images
    class Space < ::Spaces::Space

      relation_accessor :abstract

      delegate([:all, :get] => :bridge)
      delegate(path_for: :abstract)

      def pull(identifier)
        bridge.create('fromImage' => identifier)
      end

      alias_method :import, :pull

      def from_subject(subject)
        bridge.build_from_dir(path_for(subject), options_for(subject)).tap do |i|
          i.tag('repo' => subject.identifier)
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
          'dockerfile' => file_class.identifier,
          'force' => true,
          'rm' => true
        }
      end

      def initialize(abstract)
        self.abstract = abstract
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
