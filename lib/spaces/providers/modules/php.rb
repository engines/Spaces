module Providers
  class Php < ::Adapters::ModuleList

    def inline = struct.map { |s| "phpenmod #{s}" }

  end
end
