require 'resolv'

module Divisions
  class Binding < ::Emissions::TargetingSubdivision
    include Emissions::Resolvable

    def embed?; struct.type == 'embed' ;end

    def override_keys; overrides.to_h.keys ;end

    def resolved
      @resolved ||= duplicate(struct).tap { |s| s.configuration = configuration }
    end

    def configuration
      @configuration ||= OpenStruct.new(resolved_texts)
    end

    def texts
      overrides.to_h.transform_values { |v| text_from(v) }
    end

    def overrides
      default_configuration.merge(struct_configuration)
    end

    def default_configuration
      @default_configuration ||=
      if resolution.has?(:binding_target)
        resolution.binding_target&.struct
      end || OpenStruct.new
    end

    def struct_configuration; struct.configuration || OpenStruct.new ;end

    def method_missing(m, *args, &block)
      override_keys&.include?(m) ? configuration[m] : super
    end

    def respond_to_missing?(m, *)
      override_keys&.include?(m) || super
    end

  end
end
