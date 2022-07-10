module Providers
  class Pecl < ::Adapters::ModuleList

    def inline = struct.map { |s| "pecl install #{s}" }

  end
end
