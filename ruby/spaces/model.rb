require 'yaml'
require 'json'
require 'ostruct'
require_relative 'error'

module Spaces
  class Model

    class << self
      def universe
        @@universal_space ||= Universal::Space.new
      end

      def identifier
        name.split('::').join
      end

      def qualifier
        name.split('::').last.gsub(/([^\^])([A-Z])/,'\1_\2').downcase
      end

      def from_yaml(yaml)
        YAML::load(yaml)
      end

      def relation_accessor(*args)
        attr_accessor(*args)
      end

      def alias_accessor(to, from)
        alias_method to, from
        alias_method "#{to}=", "#{from}="
      end
    end

    attr_accessor :struct
    relation_accessor :descriptor

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

    def identifier
      descriptor.identifier
    end

    def static_identifier
      descriptor.static_identifier
    end

    def uniqueness
      [self.class.name, identifier]
    end

    def qualifier
      self.class.qualifier
    end

    def file_path
      "#{subspace_path}/#{self.class.identifier}"
    end

    def subspace_path
      identifier
    end

    def namespaced_name(namespace, symbol)
      "#{namespace}::#{symbol.to_s.split('_').map(&:capitalize).join}"
    end

    def to_yaml
      YAML.dump(struct)
    end

    def open_struct_from_json(json)
      JSON.parse(json, object_class: OpenStruct)
    end

    def descriptor_class
      Descriptor
    end

    def universe
      self.class.universe
    end

    def initialize(struct = nil)
      self.struct = struct
    end

    def to_s
      identifier
    end

    def method_missing(m, *args, &block)
      if struct&.to_h&.keys&.include?(m)
        struct.send(m, *args, &block)
      else
        super
      end
    end

  end
end
