module Spaces
  module Workspace

    def workspace = Pathname(ENV['ENGINES_WORKSPACE'] || default_workspace)
    def default_workspace = Pathname(ENV['TMP'] || '/tmp').join('spaces')

  end
end
