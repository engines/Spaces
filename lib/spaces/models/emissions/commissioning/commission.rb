module Commissioning
  class Commission < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      runtime_provider: :arena,
      model_class: :interface,
      [:state, :network] => :first_interface_model
    )

    alias_method :provider, :runtime_provider

    def first_interface_model; interface_models.first ;end

    def ip_address
      network.ip_address
    end

    def execute(command)
      interface.execute(command)
    end

    def interface_models
      @interface_models ||= interface.by_spaces_identifier(identifier)
    end

    def interface
      @interface ||= provider.interface_for(self)
    end

  end
end
