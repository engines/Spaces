require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class ClusterKey < Resource

        def default_configuration =
          super.merge(
            description: resource_identifier,
      			deletion_window_in_days: 10,
      			is_enabled: true,
      			enable_key_rotation: false,
      			multi_region: false
          )

      end
    end
  end
end
