require_relative 'interface'

module Providers
  module Docker
    class ImageInterface < Interface

      delegate(
        prune: :bridge,
        [:connection, :version, :info, :default_socket_url] => :klass,
      )

      def pull
        bridge.create(fromImage: output_image_identifier)
      end

      alias_method :import, :pull

      def create
        bridge.create(name: output_image_identifier)
      end

      def tag_latest(image)
        image.tag('repo' => pack.output_identifier, 'force' => true, 'tag' => 'latest')
      end

      def process_output(encoded)
        # FIX ME! The rescue is needed due to JSON parse errors
        output = JSON.parse(encoded, symbolize_names: true)
        stream.error("#{output[:error]}\n") if output[:error]
        stream.output(output[:stream]) if output[:stream]
      rescue
        stream.output("Failed to parse JSON: #{encoded}\n")
      end

      def bridge; ::Docker::Image ;end
      def model_class; Image ;end
      def file_class; Files::File ;end

    end
  end
end