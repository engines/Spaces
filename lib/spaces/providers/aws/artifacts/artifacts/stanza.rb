require_relative 'named'

module Artifacts
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

      def maximum_identifier_length = 32

      def name_snippet = nil
      def more_snippets = nil

      def tags_snippet = {tags: tags_hash}

      def configuration_snippet = configuration_hash.without(:tags)

      def arena_resource_qualification_for(resource) =
        [arena.identifier, resource.identifier].join('_')

      def arena_attachable_qualification_for(attachable) =
        [arena.identifier, configuration.send(attachable)].join('_').abbreviated_to(maximum_identifier_length)

      alias_method :qualification_for, :arena_attachable_qualification_for

      def default_binding = :"#{blueprint_identifier}"

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

    end
  end
end


class Hash
  def without_binding_keys = without(*binding_keys)
  def binding_keys = keys.select { |k| k.include?('_binding')}
end
