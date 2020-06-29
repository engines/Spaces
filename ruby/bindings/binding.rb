require 'resolv'
require_relative '../texts/text'
require_relative '../releases/subdivision'

module Bindings
  class Binding < ::Releases::Subdivision

    def override_keys; overrides.to_h.keys ;end

    def memento; resolved ;end

    def resolved; @resolved ||= duplicate(struct).tap { |s| s.variables = variables } ;end
    def variables; @variables ||= OpenStruct.new(texts.transform_values(&:resolved)) ;end

    def texts; overrides.to_h.transform_values { |v| text_from(v) } ;end
    def overrides; default_variables.merge(struct_variables) ;end

    def default_variables
      @default_variables ||= anchor_resolution.binding_anchor&.variables
    rescue NoMethodError
      OpenStruct.new
    end

    def struct_variables; struct.variables || OpenStruct.new ;end

    def text_from(value); text_class.new(origin: value, context: self) ;end
    def text_class; Texts::Text ;end

    def anchor_resolution
      @anchor_resolution ||= universe.resolutions.by(descriptor)
    rescue Errno::ENOENT => e
      universe.blueprints.by(descriptor).resolution
    end

    def descriptor; @descriptor ||= descriptor_class.new(struct.descriptor) ;end
    def identifier; struct.identifier || descriptor.identifier ;end

    def random(length); SecureRandom.hex(length.to_i) ;end

    def method_missing(m, *args, &block)
      override_keys&.include?(m) ? variables[m] : super
    end

    def respond_to_missing?(m, *)
      override_keys&.include?(m) || super
    end

  end
end
