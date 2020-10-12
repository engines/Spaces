require 'resolv'

module Divisions
  class Binding < ::Emissions::DescriptiveSubdivision

    def override_keys; overrides.to_h.keys ;end

    def emit; resolved ;end

    def resolved
      @resolved ||= duplicate(struct).tap { |s| s.variables = variables }
    end

    def variables
      @variables ||= OpenStruct.new(texts.transform_values(&:resolved))
    end

    def texts
      overrides.to_h.transform_values { |v| text_from(v) }
    end

    def overrides
      default_variables.merge(struct_variables)
    end

    def default_variables
      @default_variables ||= resolution.binding_anchor&.variables
    rescue NoMethodError
      OpenStruct.new
    end

    def struct_variables; struct.variables || OpenStruct.new ;end

    def text_from(value)
      interpolating_class.new(origin: value, division: self)
    end

    def interpolating_class; Interpolating::Text ;end

    def random(length); SecureRandom.hex(length.to_i) ;end

    def method_missing(m, *args, &block)
      override_keys&.include?(m) ? variables[m] : super
    end

    def respond_to_missing?(m, *)
      override_keys&.include?(m) || super
    end

  end
end
