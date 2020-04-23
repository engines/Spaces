require 'forwardable'
require 'yaml'
require 'json'
require 'duplicate'
require_relative '../lib/ostruct'
require_relative '../lib/array'
require_relative '../lib/string'
require_relative 'error'

module Spaces
  class Thing
    extend Forwardable

    class << self

      def identifier; name.split('::').join; end

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

    attr_accessor :struct, :klass

    delegate([:identifier, :qualifier] => :klass)

    def klass
      @klass ||= self.class
    end

    def to_yaml
      YAML.dump(struct)
    end

    def to_json
      struct&.deep_to_h&.to_json
    end

    def open_struct_from_json(json)
      JSON.parse(json, object_class: OpenStruct)
    end

    def to_s
      identifier
    end

  end
end
