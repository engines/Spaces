module Commissioning
  class Commission < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      runtime_provider: :arena,
      [:state, :network] => :interface
    )

    alias_method :provider, :runtime_provider

    def ip_address
      network[:ip_address]
    end

    def execute(command)
      interface.execute(command)
    end

    def interface
      @interface ||= provider.interface_for(self, purpose: :commissioning)
    end

  end
end
