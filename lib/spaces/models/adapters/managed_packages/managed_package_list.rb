module Adapters
  class ManagedPackageList < Division

    delegate(
      command: :installer,
      [:identifier, :struct, :installer_name] => :division
    )

    def installer
      @installer ||= default_installer_class.class_for(installer_name).new(self)
    end

    def default_installer_class = ::Packaging::Installer

  end
end
