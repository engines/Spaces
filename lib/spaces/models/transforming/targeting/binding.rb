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

    def service_string_array
      service.keys.map { |k| "#{k}=#{service[k]}"} if respond_to?(:service)
    end

    def type; struct.type || derived_features[:type] ;end

    def runtimes; struct.runtimes ;end

    def for_runtime?(value)
      generic? || runtimes&.include?("#{value}")
    end

    def generic?
      [[], nil].include?(runtimes)
    end

    def embed?; type == 'embed' ;end

    def embed_bindings
      deep_bindings_of_type(:embed)
    end

    def deep_bindings
      deep_bindings_of_type(:deep)
    end

    def deep_bindings_of_type(type)
      #TODO: can't use blueprint here ... must be more gerneric
      # #better_emission method?
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
