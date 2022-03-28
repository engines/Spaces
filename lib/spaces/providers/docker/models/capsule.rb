require_relative 'capsule_summary'

module Providers
  module Docker
    class Capsule < CapsuleSummary

      def summary
        @summary ||= super.merge(
          OpenStruct.new(
            status: state.status,
            state: state.to_h
          )
        )
      end

      def image_id; image ;end
      def names; [struct.name] ;end

    end
  end
end
