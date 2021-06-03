require 'resolv'
require_relative 'publishing'
require_relative 'graphing'
require_relative 'resolving'
require_relative 'packing'

module Divisions
  class Binding < ::Divisions::TargetingSubdivision
    include ::Divisions::Binding::Publishing
    include ::Divisions::Binding::Graphing
    include ::Divisions::Binding::Resolving
    include ::Divisions::Binding::Packing

    class << self
      def features; [:type, :identifier, :target_identifier, :configuration] ;end
    end

    delegate(publications: :universe)

    def type; struct.type || derived_features[:type] ;end

    def embed?; type == 'embed' ;end

    def runtime_binding?; ['runtime', 'containing'].include?(identifier) ;end
    def packing_binding?; ['packing'].include?(identifier) ;end

    def runtime_identifier
      blueprint.provider.type if runtime_binding?
    end

    def packing_identifier
      blueprint.provider.type if packing_binding?
    end

    def configuration; struct.configuration || derived_features[:configuration] ;end

    def target_configuration
      @target_configuration ||= blueprint.binding_target.struct
    end

    def embed_bindings
      deep_bindings_of_type(:embed)
    end

    def deep_bindings
      deep_bindings_of_type(:deep)
    end

    def deep_bindings_of_type(type)
      [self, blueprint.bindings.send("#{type}_bindings")].flatten.uniq(&:identifier)
    end

    def keys; configuration.to_h.keys ;end

    def method_missing(m, *args, &block)
      keys&.include?(m) ? configuration[m] : super
    end

    def respond_to_missing?(m, *)
      keys&.include?(m) || super
    end

    protected

    def derived_features
      @derived_features ||= {
        type: 'connect',
        configuration: OpenStruct.new
      }
    end

  end
end
