module Providers
  class Python < ::Adapters::ModuleList

    def inline = struct.map { |s| "python#{version} -m pip install --upgrade install #{s}" }

  end
end
