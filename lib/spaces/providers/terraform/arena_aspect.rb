module Providers
  module Terraform
    class ArenaAspect < ::Spaces::Model

      relation_accessor :arena

      delegate(
        [:runtime_identifier, :aspect_name_elements] => :arena
      )

      def runtime_artifact
        runtime_aspect.provider_stanzas
      end

      def initial_artifact
        %(
          terraform {
            required_providers {
              #{provider_division_aspects.flatten.map(&:required_stanza).flatten.compact.join}
            }
          }
        )
      end

      #-------------------------------------------------------------------------

      def runtime_aspect; execution_aspect_for(runtime_identifier) ;end

      def other_aspects
        other_identifiers.map { |i| provider_division_aspect_map[i] }
      end

      def execution_aspect_for(purpose); provider_division_aspect_map["#{purpose}"] ;end

      def provider_division_aspects; provider_division_aspect_map.values ;end

      def provider_division_aspect_map
        @provider_division_aspect_map ||=
          (apam = arena.provider_division_aspect_map).keys.inject({}) do |m, k|
            m.tap do
              m[k] = aspect_subtype_of(apam[k])
            end
          end
      end

      #-------------------------------------------------------------------------

      def aspect_subtype_of(provider_division_aspect)
        aspect_class_for(provider_division_aspect).new(provider_division_aspect)
      # rescue NameError
      #   provider_division_aspect
      end

      def aspect_class_for(provider_division_aspect)
        Module.const_get(aspect_class_name_for(provider_division_aspect))
      end

      def aspect_class_name_for(provider_division_aspect)
        aspect_name_elements_for(provider_division_aspect).map(&:camelize).join('::')
      end

      def aspect_name_elements_for(provider_division_aspect)
        pp aspect_name_elements
        pp provider_division_aspect.klass
        pp provider_division_aspect.aspect_name_elements
        pp [aspect_name_elements, provider_division_aspect.aspect_name_elements - ['providers']].flatten
        [aspect_name_elements, provider_division_aspect.aspect_name_elements - ['providers']].flatten
      end

      #-------------------------------------------------------------------------

      def initialize(arena)
        self.arena = arena
      end

    end
  end
end
