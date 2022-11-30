require_relative 'named'

module Artifacts
  module CloudFormation
    module Aws
      class Stanza < ::Artifacts::Stanza

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

        def runtime_qualifier = name_elements[2].camelize

        def snippets =
          {
            "#{resource_identifier}":
              [name_snippet, configuration_snippet, tags_snippet, more_snippets].
                inject({Type: "#{runtime_qualifier}::#{resource_type_here}",}) do |m, s|
                  m.merge(s || {})
                end
          }

        def name_snippet = nil

        def configuration_snippet =
          configuration_hash.without(:tags)

        def tags_snippet =
          {tags: tags_hash}

        def arena_resource_qualification_for(resource) =
          [arena.identifier, resource.identifier].join('_').hyphenated

        def arena_attachable_qualification_for(attachable) =
          [arena.identifier, configuration.send(attachable)].join('_').hyphenated.abbreviated_to(maximum_identifier_length)

        def maximum_identifier_length = 32

        alias_method :qualification_for, :arena_attachable_qualification_for

        def default_binding = :"#{blueprint_identifier.hyphenated}"

        def configuration
          @configuration ||= default_configuration.reverse_merge(super)
        end

        def more_configuration = {}

        def configuration_hash =
          with_tailored_keys(configuration&.to_h_deep || {}).
            without(*more_snippets_keys).
            without_binding_keys

        def with_tailored_keys(hash) =
          hash.transform_keys { |k| configuration_key_map[k] || k }

        def more_snippets_keys = more_configuration.keys

        def tags_hash =
          {
            'Name': resource_identifier,
            'Environment': 'var.app_environment'
          }.merge(configuration_hash[:tags] || {})

        def more_snippets = nil

      end
    end
  end
end
