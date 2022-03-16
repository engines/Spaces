module Providers
  module Docker
    class ImageInterface < Interface

      alias_method :image, :emission

      delegate(
        [:all, :prune] => :bridge,
        [:connection, :version, :info, :default_socket_url] => :klass,
      )

      def get(id)
        image_class.new(self, bridge.get(id))
      end

      def pull
        bridge.create(fromImage: output_image_identifier)
      end

      alias_method :import, :pull

      def all(options = {})
        @all ||= bridge.all(options).map { |i| image_class.new(self, i) }
      end

      def tag_latest(image)
        image.tag('repo' => image.output_identifier, 'force' => true, 'tag' => 'latest')
      end

      def bridge; ::Docker::Image ;end
      def image_class; Image ;end
      def file_class; Files::File ;end

    end
  end
end
