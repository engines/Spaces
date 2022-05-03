module Adapters
  class Pack < ResolvedEmission

    alias_method :pack, :emission

    def provider
      provider_for(:packing)
    end

    def adapter_qualifiers; [:script_copying, :file_packing, :script_running, :execution] ;end

    def adapter_map
      pack_adapter_map.merge(super)
    end

    # TODO: possible refactor ... the levels of dynamic class generation are a repeating pattern
    def pack_adapter_map
      @pack_adapter_map ||= adapter_qualifiers.inject({}) do |m, q|
        m.tap { m[q] = pack_adapter_for(q) }
      end.compact
    end

    def pack_adapter_for(qualifier)
      pack_adapter_class_for(qualifier).new(provider, pack)
    end

    def pack_adapter_class_for(qualifier)
      class_for(adapter_name_elements, qualifier)
    rescue NameError
      begin
        class_for(nesting_elements, qualifier)
      rescue NameError
        begin
          class_for(adapter_name_elements, default_name_elements)
        rescue NameError
          default_emission_adapter_class
        end
      end
    end

  end
end
