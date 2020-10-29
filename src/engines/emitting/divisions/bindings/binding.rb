require 'resolv'

module Divisions
  class Binding < ::Emissions::DescriptiveSubdivision
    include Emissions::Resolvable

    def override_keys; overrides.to_h.keys ;end

    def resolved
      @resolved ||= duplicate(struct).tap { |s| s.variables = variables }
    end

    def variables
      @variables ||= OpenStruct.new(resolved_texts)
    end

    def texts
      overrides.to_h.transform_values { |v| text_from(v) }
    end

    def overrides
      default_variables.merge(struct_variables)
    end

    def default_variables
      @default_variables ||=
      if resolution.has?(:binding_anchor)
        resolution.binding_anchor&.variables
      end || OpenStruct.new
    end

    def struct_variables; struct.variables || OpenStruct.new ;end

    def method_missing(m, *args, &block)
      override_keys&.include?(m) ? variables[m] : super
    end

    def respond_to_missing?(m, *)
      override_keys&.include?(m) || super
    end

  end
end
