require_relative '../installations/division'
require_relative 'binding'

module Bindings
  class Bindings < ::Installations::Division

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@bindings_step_precedence ||= { late: [:persistence] }
      end

      def script_lot
        @@bindings_script_lot ||= [:persistent_directories, :persistent_files]
      end
    end

    def layers_for(group)
      [super, all.map { |a| a.layers_for(group) }]
    end

    def all
      @all ||= installation.struct.bindings.map { |d| binding_class.new(struct: d, context: self) }
    end

    def named(name)
      all.detect { |b| b.identifier == name.to_s }
    end

    def product
      all.map { |a| a.product }
    end

    def persistent(symbol)
      all.inject({}) do |m, b|
        m[b.identifier] = b.struct.dig(:persistent, symbol)
        m
      end.compact
    end

    def binding_class
      Binding
    end

    def method_missing(m, *args, &block)
      named(m) || super
    end

  end
end
