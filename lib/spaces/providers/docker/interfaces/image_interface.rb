require_relative 'interface'

module Providers
  module Docker
    class ImageInterface < Interface

      alias_method :image, :emission

      delegate(
        prune: :bridge,
        [:connection, :version, :info, :default_socket_url] => :klass,
      )

      def pull
        bridge.create(fromImage: output_image_identifier)
      end

      alias_method :import, :pull

      def tag_latest(image)
        image.tag('repo' => image.output_identifier, 'force' => true, 'tag' => 'latest')
      end

      def bridge; ::Docker::Image ;end
      def model_class; Image ;end
      def file_class; Files::File ;end

    end
  end
end
