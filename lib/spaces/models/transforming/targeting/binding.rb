require 'resolv'
require_relative 'node'
require_relative 'flattening'
require_relative 'resolving'

module Targeting
  class Binding < ::Targeting::Node
    include ::Targeting::Flattening
    include ::Targeting::Resolving

    class << self
      def features =
        [:type, :runtimes, :identifier, :target_identifier, :configuration, :service]
    end

    def application_identifier = inject? ? identifier : target_identifier

    def configuration = struct.configuration
    def service = struct.service

    def type = struct.type || derived_features[:type]

    def inject? = type == 'configure'
    def embed? = type == 'embed'

    def runtimes = struct.runtimes

    def for_runtime?(value) = generic? || runtimes&.include?("#{value}")

    def generic? = [[], nil].include?(runtimes)

    def configure_bindings = deep_bindings_of_type(:configure)

    alias_method :inject_bindings, :configure_bindings

    def embed_bindings = deep_bindings_of_type(:embed)

    def deep_bindings = deep_bindings_of_type(:deep)

    def deep_bindings_of_type(type) =
      [self, blueprint&.bindings&.send("#{type}_bindings")].flatten.compact.uniq(&:identifier)
      #TODO: can't use blueprint here ... must be more gerneric
      # #better_emission method?

    def target_struct = blueprint&.binding_target&.struct
      #TODO: can't use blueprint here ... must be more generic
      # #better_emission method?

    protected

    def derived_features
      @derived_features ||= {type: 'connect'}
    end

  end
end
