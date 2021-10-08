module Adapters
  class Container < DivisionAdapter

    delegate [:provisions, :image_name, :commissioning_scripts] => :division
    delegate [:connections_down, :connect_bindings, :volumes] => :provisions

    def connect_services_snippets
      connect_bindings.map do |c|
        r = c.resolution
        if r.has?(:service_tasks)
          r.service_tasks.connection_snippet_for(c)
        end
      end.compact.join
    end

    def device_snippets
      volumes.all.map(&:device_snippets).join
    end

  end
end
