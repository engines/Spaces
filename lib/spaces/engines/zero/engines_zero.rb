class EnginesZero < ::Spaces::Thing

  class << self
    def engines_role_map
      {
        packing: [:docker],
        provisioning: [:terraform],
        runtime: [:docker]
        # dns: [:power_dns]
      }
    end

    def primary_provider_roles; [:packing, :provisioning, :runtime] ;end
  end

  delegate(
    [:engines_role_map, :primary_provider_roles] => :klass,
    keys: :engines_role_map
  )

  alias_method :role_map, :engines_role_map

  def class_map
    @class_map ||= role_map.transform_values do |v|
      v.map { |c| Module.const_get(class_name_for(c)) }
    end
  end

  def module_map
    @module_map ||= role_map.transform_values do |v|
      v.map { |c| Module.const_get(module_name_for(c)) }
    end
  end

  #TODO: refactor
  def class_name_for(role); "#{module_name_for(role)}::#{role.camelize}" ;end
  def module_name_for(role); "#{namespace}::#{role.camelize}" ;end
  def namespace; '::Providers' ;end

end
