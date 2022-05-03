module Commissioning
  class Commission < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      model_class: :interface,
      [:state, :network] => :first_interface_model
    )

    def first_interface_model; interface_models.first ;end

    def network
      first_interface_model&.network
    end

    def ip_address
      network&.ip_address
    end

    def execute(command)
      interface.execute(command)
    end

    def interface_models
      @interface_models ||= interface.by_resolution_identifier(identifier)
    end

    def interface
      @interface ||= provider.interface_for(self)
    end

  end
end
