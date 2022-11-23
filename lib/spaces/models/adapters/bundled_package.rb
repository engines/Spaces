require_relative 'package_access'

module Adapters
  class BundledPackage < PackageAccess

    delegate(branch: :target)

    def default_accessor_class = ::Packaging::Extractor

    def accessor_name = division.format

  end
end
