module Providers
  class Apache < ::Adapters::ManagedPackageList

    def inline = struct.map { |s| "a2enmod #{s}" }

  end
end
