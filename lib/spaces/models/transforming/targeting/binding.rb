require 'resolv'
require_relative 'subdivision'
require_relative 'graphing'
require_relative 'resolving'

module Targeting
  class Binding < ::Targeting::Subdivision
    include ::Targeting::Graphing
    include ::Targeting::Resolving

    class << self
      def features; [:type, :runtimes, :identifier, :target_identifier, :configuration] ;end
    end

    def type; struct.type || derived_features[:type] ;end # NOW WHAT?

    def runtimes; struct.runtimes ;end # NOW WHAT?

    def for_runtime?(value) # NOW WHAT?
      generic? || runtimes&.include?("#{value}")
    end

    def generic? # NOW WHAT?
      [[], nil].include?(runtimes)
    end

    def embed?; type == 'embed' ;end # NOW WHAT?

    def embed_bindings # NOW WHAT?
      deep_bindings_of_type(:embed)
    end

    def deep_bindings # NOW WHAT?
      deep_bindings_of_type(:deep)
    end

    def deep_bindings_of_type(type) # NOW WHAT?
      #TODO: can't use blueprint here ... must be more gerneric
      # #better_emission method?
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
