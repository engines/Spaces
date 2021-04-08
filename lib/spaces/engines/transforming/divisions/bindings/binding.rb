require 'resolv'

module Divisions
  class Binding < ::Divisions::TargetingSubdivision

    class << self
      def features; [:type, :identifier, :target_identifier, :configuration] ;end
    end

    alias_accessor :arena, :emission

    def type; struct.type || derived_features[:type] ;end

    def embed?; type == 'embed' ;end

    def implies_packable?; !embed? ;end

    def runtime_binding?; identifier == 'containing' ;end

    def runtime_type
      blueprint.provider.type if runtime_binding?
    end

    def configuration; struct.configuration || derived_features[:configuration] ;end

    def localized
      empty.tap do |m|
        m.struct = struct.without(:target).tap do |s|
          s.identifier ||= target_identifier
          s.target_identifier = target_identifier
        end
      end
    end

    def flattened
      empty.tap do |m|
        m.struct = struct.tap do |s|
          s.configuration = flattened_configuration
        end
      end
    end

    def flattened_configuration
      unresolved_struct.merge(target_configuration).merge(configuration)
    end

    def resolved
      super.tap do |d|
        d.struct.configuration = Divisions::ResolvableStruct.new(struct.configuration, self).resolved
      end
    end

    def infix_qualifier; target_identifier ;end

    def target_configuration
      @target_configuration ||= blueprint.binding_target.struct
    end

    def keys; configuration.to_h.keys ;end

    def environment_variables
      configuration.to_h.map { |k, v| "--env=#{k}=#{v}" }.join(' ')
    end

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
