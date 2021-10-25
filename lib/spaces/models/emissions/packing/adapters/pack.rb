module Adapters
  class Pack < Emission

    delegate(packing_provider: :arena)

    alias_method :provider, :packing_provider
    alias_method :pack, :emission

    def adapter_qualifiers; [:file_packing, :script_running] ;end

    def adapter_map
      pack_adapter_map.merge(super)
    end

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
          default_adapter_class
        end
      end
    end

  end
end
