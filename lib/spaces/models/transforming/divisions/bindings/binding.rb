require 'resolv'
require_relative 'publishing'
require_relative 'graphing'
require_relative 'resolving'
require_relative 'packing'

module Divisions
  class Binding < ::Divisions::TargetingSubdivision
    include ::Divisions::Binding::Publishing # NOW WHAT?
    include ::Divisions::Binding::Graphing
    include ::Divisions::Binding::Resolving # NOW WHAT?
    include ::Divisions::Binding::Packing # NOW WHAT?

    class << self
      def features; [:type, :runtimes, :identifier, :target_identifier, :configuration] ;end
    end

    delegate(binder?: :blueprint) # NOW WHAT?

    def type; struct.type || derived_features[:type] ;end # NOW WHAT?

    def runtimes; struct.runtimes ;end # NOW WHAT?

    def for_runtime?(value) # NOW WHAT?
      generic? || runtimes&.include?("#{value}")
    end

    def generic? # NOW WHAT?
      [[], nil].include?(runtimes)
    end

    def embed?; type == 'embed' ;end # NOW WHAT?

    def configuration # NOW WHAT?
      struct.configuration || derived_features[:configuration]
    end

    def target_configuration # NOW WHAT?
      @target_configuration ||= blueprint.binding_target.struct
    end

    def embed_bindings # NOW WHAT?
      deep_bindings_of_type(:embed)
    end

    def deep_bindings # NOW WHAT?
      deep_bindings_of_type(:deep)
    end

    def deep_bindings_of_type(type) # NOW WHAT?
      [self, blueprint.bindings.send("#{type}_bindings")].flatten.uniq(&:identifier)
    end

    def keys; configuration.to_h.keys ;end # NOW WHAT?

    def method_missing(m, *args, &block)
      keys&.include?(m) ? configuration[m] : super # NOW WHAT?
    end

    def respond_to_missing?(m, *)
      keys&.include?(m) || super
    end

    protected

    def derived_features
      @derived_features ||= {
        type: 'connect', # NOW WHAT?
        configuration: OpenStruct.new
      }
    end

  end
end
