module Providers
  module Docker
    class Model < ::Spaces::Model

      relation_accessor :interface
      relation_accessor :model_interface

      delegate(all: :interface)

      def summary
        @summary ||= OpenStruct.new(
          resolution_identifier: resolution_identifier,
          arena_identifier: arena_identifier,
          application_identifier: application_identifier,
          identifier: identifier,
          runtime: runtime_qualifier,
        )
      end

      def arena_identifier = resolution_identifier.high
      def application_identifier = resolution_identifier.low

      def runtime_qualifier = name_elements[1].snakize
      alias_method :runtime, :runtime_qualifier

      def execute(instruction)
        send(instruction)
      rescue NoMethodError
        raise ::Spaces::Errors::NoInstruction, {instruction: instruction, interface: interface.klass.name}
      rescue ::Docker::Error::DockerError => e
        raise ::Spaces::Errors::InterfaceError, {message: e.message}
      end

      def initialize(interface, model_interface)
        self.interface = interface
        self.model_interface = model_interface
        self.struct = model_interface.info.to_struct
      end

      def to_h_deep = to_h

      def method_missing(m, **args, &block)
        return model_interface.send(m, **args, &block) if model_interface.respond_to?(m)
        super
      end

      def respond_to_missing?(m, *)
        model_interface.respond_to?(m) || super
      end

    end
  end
end
