# require_relative 'runtime_providing'
#
module Providers
  module Terraform
    module Providing
      # include RuntimeProviding

      #-------------------------------------------------------------------------

      def runtime_aspect; provider_aspect_for(runtime_identifier) ;end

      def other_aspects
        other_identifiers.map { |i| provider_aspect_map[i] }
      end

      def provider_aspect_for(purpose); provider_aspect_map["#{purpose}"] ;end

      def provider_aspects; provider_aspect_map.values ;end

      def provider_aspect_map
        @provider_aspect_map ||=
          (apam = arena.provider_aspect_map).keys.inject({}) do |m, k|
            m.tap do
              m[k] = aspect_subtype_of(apam[k])
            end
          end
      end

      #-------------------------------------------------------------------------

      def aspect_subtype_of(provider_aspect)
        aspect_class_for(provider_aspect).new(provider_aspect, space)
      # rescue NameError
      #   provider_aspect
      end

      def aspect_class_for(provider_aspect)
        Module.const_get(aspect_class_name_for(provider_aspect))
      end

      def aspect_class_name_for(provider_aspect)
        aspect_name_elements_for(provider_aspect).map(&:camelize).join('::')
      end

      def aspect_name_elements_for(provider_aspect)
        [aspect_name_elements, provider_aspect.aspect_name_elements - ['providers']].flatten
      end

      #-------------------------------------------------------------------------

      def runtime_artifacts
        runtime_aspect.provider_stanzas
      end

      def initial_artifacts
        %(
          terraform {
            required_providers {
              #{provider_aspects.flatten.map(&:required_stanza).flatten.compact.join}
            }
          }
        )
      end

    end
  end
end
