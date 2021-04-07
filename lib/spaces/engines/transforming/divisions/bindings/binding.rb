require 'resolv'
require_relative 'publishing'
require_relative 'resolving'
require_relative 'packing'

module Divisions
  class Binding < ::Divisions::TargetingSubdivision
    include ::Divisions::Binding::Publishing
    include ::Divisions::Binding::Resolving
    include ::Divisions::Binding::Packing

    class << self
      def features; [:type, :identifier, :target_identifier, :configuration] ;end
    end

    alias_accessor :arena, :emission

    def type; struct.type || derived_features[:type] ;end

    def embed?; type == 'embed' ;end

    def runtime_binding?; identifier == 'containing' ;end

    def runtime_type
      blueprint.provider.type if runtime_binding?
    end

    def configuration; struct.configuration || derived_features[:configuration] ;end

    def target_configuration
      @target_configuration ||= blueprint.binding_target.struct
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
