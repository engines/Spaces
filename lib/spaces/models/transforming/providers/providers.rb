module Providers
  module Providers

    def provider_for(purpose); provider_map[purpose] ;end

    def providers
      provider_map.values
    end

    def provider_map
      @provider_map ||= role_keys.inject({}) do |m, k|
        m.tap do
          m[k] = class_map[k].first.new(k)
        end.merge(m[k].provider_map)
      end
    end

    def provider_qualifier_map
      provider_map.transform_values(&:qualifier)
    end

    def provider_qualifiers
      provider_qualifier_map.values.uniq
    end

    def role_keys; provider_role_map.keys ;end

    def class_map
      @class_map ||= provider_role_map.transform_values do |v|
        v.map { |c| Module.const_get(class_name_for(c)) }
      end
    end

    def module_map
      @module_map ||= provider_role_map.transform_values do |v|
        v.map { |c| Module.const_get(module_name_for(c)) }
      end
    end

    def provider_role_map; {} ;end

    #TODO: refactor
    def class_name_for(role); "#{module_name_for(role)}::#{role.camelize}" ;end
    def module_name_for(role); "#{namespace}::#{role.camelize}" ;end
    def namespace; '::Providers' ;end

  end
end
