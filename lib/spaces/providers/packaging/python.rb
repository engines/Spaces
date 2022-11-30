require_relative 'installer'

module Packaging
  class Python < Installer

    class << self
      def system_dependencies = [:pip]
    end

    delegate(
      resolutions: :universe,
      index_url: :state
    )

    def command =
      struct.map { |s| "python#{version} -m pip install --upgrade install #{s}" }

    def configuration =
      %(
        [global]
        index-url = #{index_url}
      )

    def configure
      path.mkpath
      path.join(basename).write(configuration)
    end

    def clean
      path.rmtree
    end

    def path = resolution_path.join('packing/early/.config/pip')
    def resolution_path = resolutions.writing_path_for(state.emission)
    def basename = 'pip.conf'

  end

  Pip = Python

end
