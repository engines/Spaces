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

      def process_output(encoded)
        # FIX ME! The rescue is needed due to JSON parse errors
        begin
          j = JSON.parse(encoded, symbolize_names: true)
          stream.output(j[:stream]) if j[:stream]
          stream.error("#{j[:error].strip}\n") if j[:error]
        rescue JSON::ParserError => e
          stream.error("Failed to parse JSON: #{e}\n")
        end
      end

      def bridge; ::Docker::Image ;end
      def model_class; Image ;end
      def file_class; Files::File ;end

    end
  end
end
