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
        if s = stream
          j = JSON.parse(encoded, symbolize_names: true)
          s.error("#{j[:error]}\n") if j[:error]
          s.output(j[:stream]) if j[:stream]
        end
      rescue
        stream&.output("Failed to parse JSON: #{encoded}\n")
      end

      def bridge = ::Docker::Image
      def model_class = Image
      def file_class = Files::File

    end
  end
end
