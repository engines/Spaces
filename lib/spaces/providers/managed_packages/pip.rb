module Providers
  class Pip < ::Adapters::ManagedPackageList

    def inline = struct.map { |s| "python#{version} -m pip install --upgrade install #{s}" }

  end

  Python = Pip
end
