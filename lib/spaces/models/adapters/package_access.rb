module Adapters
  class PackageAccess < Division

    delegate(command: :accessor)

    def accessor
      @accessor ||= default_accessor_class.class_for(accessor_name).new(self)
    end

  end
end
