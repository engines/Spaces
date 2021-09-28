require_relative 'providing'

module Providers
  module Terraform
    module RuntimeProviding
      include Providing

      def runtime_aspect
        @runtime_aspect ||= specific_runtime_class.new(runtime_provider, space)
      end

      def specific_runtime_class
        Module.const_get(specific_runtime_class_name)
      end

      def specific_runtime_class_name
        runtime_aspect_name_elements.map(&:camelize).join('::')
      end

      def runtime_aspect_name_elements
        [name_array.uniq, runtime_provider.aspect_name_elements - ['providers']].flatten
      end

    end
  end
end
