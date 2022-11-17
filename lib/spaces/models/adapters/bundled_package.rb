require_relative 'package'

module Adapters
  class BundledPackage < Package

    delegate(branch: :target)

    def default_accessor_class = ::Packaging::Extractor

    def accessor_name = division.format

  end
end
