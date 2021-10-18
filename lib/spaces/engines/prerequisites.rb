module Engines
  module Prerequisites

    def prerequisite_for(purpose); prerequisite_map[purpose] ;end

    def prerequisites
      prerequisite_map.values
    end

    def prerequisite_map
      @prerequisite_map ||= role_keys.inject({}) do |m, k|
        m.tap do
          m[k] = class_map[k].first.new(k)
        end
      end
    end

    def role_keys; prerequisite_role_map.keys ;end

    def class_map
      @class_map ||= prerequisite_map.transform_values do |v|
        v.map { |c| Module.const_get(class_name_for(c)) }
      end
    end

    def module_map
      @module_map ||= prerequisite_role_map.transform_values do |v|
        v.map { |c| Module.const_get(module_name_for(c)) }
      end
    end

    def prerequisite_role_map; {} ;end

    #TODO: refactor
    def class_name_for(role); "#{module_name_for(role)}::#{role.camelize}" ;end
    def module_name_for(role); "#{namespace}::#{role.camelize}" ;end
    def namespace; '::Providers' ;end

  end
end
