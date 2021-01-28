require 'resolv'

module Divisions
  class Binding < ::Emissions::TargetingSubdivision

    def embed?; struct.type == 'embed' ;end

    def inflated
      duplicate(itself).tap { |i| i.struct.configuration = inflated_configuration }
    end

    def inflated_configuration
      target_configuration.merge(struct_configuration)
    end

    def target_configuration
      @target_configuration ||=
      if blueprint.has?(:binding_target)
        blueprint.binding_target&.struct
      end || OpenStruct.new
    end

    def struct_configuration; struct.configuration || OpenStruct.new ;end

    def keys; struct_configuration.to_h.keys ;end

    def method_missing(m, *args, &block)
      keys&.include?(m) ? configuration[m] : super
    end

    def respond_to_missing?(m, *)
      keys&.include?(m) || super
    end

  end
end
