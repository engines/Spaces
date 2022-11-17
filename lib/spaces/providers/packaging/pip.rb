require_relative 'installer'

module Packaging
  class Pip < Installer

    def command =
      struct.map { |s| "python#{version} -m pip install --upgrade install #{s}" }

    def configuration_for(repository) =
      %(
        [global]
        index-url = repository.index_url
      )

  end

end
