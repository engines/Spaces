module Providers
  class Pear < ::Adapters::ManagedPackageList

    def inline = struct.map { |s| "pear install #{s}" }

  end
end
