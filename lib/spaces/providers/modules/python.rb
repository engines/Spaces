module Providers
  class Python < ::Adapters::ManagedPackageList

    def inline = struct.map { |s| "python#{version} -m pip install --upgrade install #{s}" }

  end
end
