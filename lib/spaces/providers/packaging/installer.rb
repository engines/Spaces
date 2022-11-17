require_relative 'accessor'

module Packaging
  class Installer < Accessor

    class << self
      def name_map =
        {
          apache: :a2enmod,
          php: :phpenmod,
          lua: :luarocks
        }

      def class_for(name)
        super
      rescue NameError => e
        klass
      end
    end

    delegate(name_map: :klass)

    def command = struct.map { |s| "#{command_type} install #{s}" }

    def command_type = name_map[identifier] || identifier

  end
end
