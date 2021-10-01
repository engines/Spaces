module ProviderAspects
  class Container < Aspect

    delegate [:provisions, :image_name, :commissioning_scripts] => :division
    delegate [:connections_down, :connect_bindings, :volumes] => :provisions

    def connect_services_stanzas
      connect_bindings.map do |c|
        r = c.resolution
        if r.has?(:service_tasks)
          r.service_tasks.connection_stanza_for(c)
        end
      end.compact.join
    end

    def device_stanzas
      volumes.all.map(&:device_stanzas).join
    end

  end
end
