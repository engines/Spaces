module Artifacts
  module Aws
    class CapsuleStanza < Stanza

      class << self
        def resource_type_map = {}
      end

      delegate resource_type_map: :klass

      def resource_type_here =
        resource_type_mapped || resource_type_derived
          qualifier.split('_')[0..-2].join('::')

      def resource_type_mapped =
        "#{resource_type_map[compute_service_identifier&.to_sym]}"

      def resource_type_derived =
        qualifier.split('_')[0..-2].join(joiner)

      def joiner = '_'

    end
  end
end
