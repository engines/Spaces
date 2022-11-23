require_relative '../package_access'

module Adapters
  class ManagedPackageList < PackageAccess

    delegate(
      [:identifier, :struct, :installer_name] => :division
    )

    alias_method :accessor_name, :installer_name

    def default_accessor_class = ::Packaging::Installer

  end
end
