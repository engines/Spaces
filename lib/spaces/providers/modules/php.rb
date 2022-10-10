module Providers
  class Php < ::Adapters::ManagedPackageList

    def inline = struct.map { |s| "phpenmod #{s}" }

  end
end
