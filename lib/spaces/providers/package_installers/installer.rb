module PackageInstallers
  class Installer < ::Spaces::Thing

    relation_accessor :adapter

    delegate(
      division: :adapter,
      struct: :division
    )

    def initialize(adapter)
      self.adapter = adapter
    end

  end
end
