module Artifacts
  module Aws
    module Stanzas
      class Stanza < ::Artifacts::Stanzas::Stanza

        class << self
          def default_configuration = OpenStruct.new

          def configuration_key_map =
            {
              cpus: :cpu
            }
        end

        delegate(
          [:default_configuration, :configuration_key_map] => :klass
        )

        def compute_qualifier = :aws

        def arena_resource_qualification_for(resource) =
          [arena.identifier, resource.identifier].join('_').hyphenated

        def arena_attachable_qualification_for(attachable) =
          [arena.identifier, configuration.send(attachable)].join('_')

        alias_method :qualification_for, :arena_attachable_qualification_for

        def default_binding = :"#{blueprint_identifier.hyphenated}"

        def configuration
          @configuration ||= default_configuration.reverse_merge(super)
        end

        def more_configuration = {}

        def configuration_hash =
          with_tailored_keys(configuration&.deep_to_h || {}).
            without(*more_snippets_keys).
            without_binding_keys

        def with_tailored_keys(hash) =
          hash.transform_keys { |k| configuration_key_map[k] || k }

        def more_snippets_keys = more_configuration.keys

        def tags_hash =
          {
            name: resource_identifier,
            environment: environment_tag
          }.merge(configuration_hash[:tags] || {})

        def environment_tag = [:Engines, provider.qualifier.camelize, nesting_elements.take(2)].flatten.join(' ')

      end
    end
  end
end

class Hash
  def without_binding_keys = without(*binding_keys)
  def binding_keys = keys.select { |k| k.include?('_binding')}
end
