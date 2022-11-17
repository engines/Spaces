module PackageInstallers
  class Installer < ::Spaces::Thing

    class << self
      def name_map =
        {
          apache: :a2enmod,
          php: :phpenmod,
          lua: :luarocks
        }
    end

    relation_accessor :adapter

    delegate(
      name_map: :klass,
      [:identifier, :struct] => :adapter
    )

    def command = struct.map { |s| "#{command_type} install #{s}" }

    def command_type = name_map[identifier] || identifier

    def initialize(adapter)
      self.adapter = adapter
    end

  end
end
