module PackageInstallers
  class Installer < ::Packaging::Accessor

    class << self
      def name_map =
        {
          apache: :a2enmod,
          php: :phpenmod,
          lua: :luarocks
        }

      def class_for(name)
        super(:package_installers, name.to_s.camelize)
      rescue NameError => e
        klass
      end
    end

    delegate(name_map: :klass)

    def command = struct.map { |s| "#{command_type} install #{s}" }

    def command_type = name_map[identifier] || identifier

  end
end
