require 'resolv'
require_relative 'node'
require_relative 'flattening'
require_relative 'resolving'

module Targeting
  class Binding < ::Targeting::Node
    include ::Targeting::Flattening
    include ::Targeting::Resolving

    class << self
      def features; [:type, :runtimes, :identifier, :target_identifier, :configuration, :service] ;end
    end

    def application_identifier
      inject? ? identifier : target_identifier
    end

    def configuration; struct.configuration ;end
    def service; struct.service ;end

    def type; struct.type || derived_features[:type] ;end

    def inject?; type == 'configure' ;end
    def embed?; type == 'embed' ;end

    def runtimes; struct.runtimes ;end

    def for_runtime?(value)
      generic? || runtimes&.include?("#{value}")
    end

    def generic?
      [[], nil].include?(runtimes)
    end

    def configure_bindings
      deep_bindings_of_type(:configure)
    end

    alias_method :inject_bindings, :configure_bindings

    def embed_bindings
      deep_bindings_of_type(:embed)
    end

    def deep_bindings
      deep_bindings_of_type(:deep)
    end

    def deep_bindings_of_type(type)
      #TODO: can't use blueprint here ... must be more gerneric
      # #better_emission method?
      [self, blueprint&.bindings&.send("#{type}_bindings")].flatten.compact.uniq(&:identifier)
    end

    def target_struct
      #TODO: can't use blueprint here ... must be more generic
      # #better_emission method?
      blueprint&.binding_target&.struct
    end

    protected

    def derived_features
      @derived_features ||= {type: 'connect'}
    end

  end
end
