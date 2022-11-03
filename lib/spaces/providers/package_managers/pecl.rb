module Providers
  class Pecl < ::Adapters::ManagedPackageList

    def inline = struct.map { |s| "pecl install #{s}" }

  end
end
