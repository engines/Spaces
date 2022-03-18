require_relative 'container_summary'

module Providers
  module Docker
    class Container < ContainerSummary

      def summary
        @summary ||= super.merge(
          status: state.status,
          state: state.to_h
        )
      end

      def image_id; image ;end
      def names; [struct.name] ;end

    end
  end
end
