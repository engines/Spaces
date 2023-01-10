module Artifacts
  module Aws
    module Stanzas
      class Capsule < Stanza

        def resource_type = resource_type_mapped || resource_type_derived

        def resource_type_mapped =
          "#{resource_type_map[compute_service_identifier&.to_sym]}"

        def resource_type_derived =
          qualifier.split('_')[0..-2].join(joiner)

        def joiner = '_'

      end
    end
  end
end
