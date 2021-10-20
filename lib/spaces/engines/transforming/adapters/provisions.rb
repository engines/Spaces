require_relative 'emission'

module Adapters
  class Provisions < Emission

    delegate(
      [:provisioning_provider, :runtime_qualifier] => :arena,
    )

    alias_method :provider, :provisioning_provider
    alias_method :provisions, :emission

    def adapter_name_elements
      [super, runtime_qualifier].flatten
    end

    def image_name
      image&.name
    end

    def image
      images&.all&.detect { |i| i.type == runtime_qualifier }
    end

  end
end
