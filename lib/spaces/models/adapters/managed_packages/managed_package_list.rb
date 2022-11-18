module Adapters
  class ManagedPackageList < Division

    class << self
      def installer_class_for(name) = class_for(:package_installers, name.to_s.camelize)
    end

    delegate(
      installer_class_for: :klass,
      command: :installer,
      installer_name: :division
    )

    def installer
      @installer ||= installer_class_for(installer_name).new(self)
    end

  end
end
