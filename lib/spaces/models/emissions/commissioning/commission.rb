module Commissioning
  class Commission < ::Resolving::Emission

    class << self
      def composition_class = Composition
    end

    delegate(
      model_class: :interface,
      [:state, :network] => :first_interface_model
    )

    def first_running = commissioned_runtime.first

    def network = first_running.network

    def ip_address = network.ip_address

    def execute(command)
      interface.execute(command)
    end

    def commissioned_runtime
      @commissioned_runtime ||= interface.by_resolution_identifier(identifier)
    end

    def interface
      @interface ||= provider.interface_for(self)
    end

  end
end
