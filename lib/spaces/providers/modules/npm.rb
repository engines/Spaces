module Providers
  class Npm < ::Adapters::ManagedPackageList

    def inline = struct.map { |s| "npm install #{s}" }

  end
end
