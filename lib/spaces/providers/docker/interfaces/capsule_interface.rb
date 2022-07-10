require_relative 'interface'

module Providers
  module Docker
    class CapsuleInterface < Interface

      delegate(delete: :bridge)

      def execute(command)
        container.send(command)
      end

      def by_image_id(image_id) =
        all.select { |c| c.image_id == image_id }.reverse

      def by_resolution_identifier(identifier) =
        all.select { |c| c.resolution_identifier == identifier }.reverse

      def bridge = ::Docker::Container
      def model_class = Capsule
      def summary_class = CapsuleSummary

    end
  end
end
