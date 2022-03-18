module Providers
  module Docker
    class Model < ::Spaces::Model

      relation_accessor :interface
      relation_accessor :model_interface

      delegate(all: :interface)

      def initialize(interface, model_interface)
        self.interface = interface
        self.model_interface = model_interface
        self.struct = model_interface.info.to_struct
      end

    end
  end
end
