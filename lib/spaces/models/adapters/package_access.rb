module Adapters
  class PackageAccess < Division

    delegate([:command, :system_dependencies] => :accessor)

    def accessor
      @accessor ||= default_accessor_class.class_for(accessor_name).new(self)
    end

  end
end
