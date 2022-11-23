require_relative 'installer'

module Packaging
  class Php < Installer

    def command = struct.map { |s| "#{command_type} #{s}" }

  end
end
