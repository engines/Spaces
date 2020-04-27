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
      define_method (:identifier) { name.split('::').join }
      define_method (:namespace) { name.split('::')[..-2].join.snakize }
      define_method (:qualifier) { name.split('::').last.snakize }
      define_method (:from_yaml) { |y| YAML::load(y) }

      define_method (:relation_accessor) { |*args| attr_accessor(*args) }

      def alias_accessor(to, from)
        alias_method to, from
        alias_method "#{to}=", "#{from}="
      end
    end

    attr_accessor :struct, :klass

    delegate(
      [:identifier, :namespace, :qualifier] => :klass,
      to_h: :struct
    )

    alias_method :context_identifier, :qualifier

    define_method (:klass) { @klass ||= self.class }
    define_method (:to_yaml) { YAML.dump(struct) }
    define_method (:to_json) { struct&.deep_to_h&.to_json }
    define_method (:open_struct_from_json) { |j| JSON.parse(j, object_class: OpenStruct) }
    define_method (:to_s) { identifier }

    def initialize(struct: nil)
      self.struct = struct
    end

    def method_missing(m, *args, &block)
      if struct&.to_h&.keys&.include?(m.to_s.sub('=', '').to_sym)
        struct.send(m, *args, &block)
      else
        super
      end
    end

  end
end
