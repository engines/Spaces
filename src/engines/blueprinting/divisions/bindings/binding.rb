require 'resolv'

module Divisions
  class Binding < ::Emissions::TargetingSubdivision

    def embed?; struct.type == 'embed' ;end

    def keys; struct_configuration.to_h.keys ;end

    def struct_configuration; struct.configuration || OpenStruct.new ;end

    def method_missing(m, *args, &block)
      keys&.include?(m) ? configuration[m] : super
    end

    def respond_to_missing?(m, *)
      keys&.include?(m) || super
    end

  end
end
