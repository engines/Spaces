module Providers
  class Npm < ::Adapters::ModuleList

    def inline = struct.map { |s| "npm install #{s}" }

  end
end
