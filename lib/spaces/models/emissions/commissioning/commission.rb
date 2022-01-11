module Commissioning
  class Commission < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      runtime_provider: :arena,
      state: :interface
    )

    alias_method :provider, :runtime_provider

    def execute(command)
      interface.execute(command)
    end

    def interface
      @interface ||= provider.interface_for(self, purpose: :commissioning)
    end

  end
end
