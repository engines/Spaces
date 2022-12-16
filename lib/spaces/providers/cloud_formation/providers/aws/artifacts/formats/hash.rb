module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class Hash < ::Artifacts::Format

          def runtime_qualifier = name_elements[2]

          def content =
            {
              "#{resource_identifier}":
                all_the_snippets.inject({type: resource_type}) do |m, s|
                    m.merge(s || {})
                  end
            }.deep(:camelize, of: :keys)

          def resource_identifier = [super, holder.resource_type].join('_').underscore.camelize

          def resource_type =
            "#{runtime_qualifier.upcase}_#{super}".amazonize

          def all_the_snippets =
            [
              name_snippet,
              dependency_snippet,
              configuration_snippet,
              tags_snippet
            ].compact

          def name_snippet =
            {name: resource_identifier}

          def dependency_snippet = {}

          def configuration_snippet =
            {
              properties: configuration_hash.without(:tags).merge(more_snippets)
            }

          def tags_snippet = {tags: tags_hash}

          def more_snippets = {}

          def qualification_for(attachable, type=nil) =
            [super(attachable), type_for(type)].
              compact.join('_').underscore.camelize

          def resource_type_map_class = ResourceTypeMap

        end
      end
    end
  end
end
