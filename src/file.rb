# frozen_string_literal: true

module Fs


  # Add an extension to a path
  #
  # Warning. If path already has an extension it will be replaced
  #
  # @param path [Pathname] the path to add the extension to.
  # @param ext [String] the extension name without the "."
  # @return [Pathname]
  def add_ext(path, ext)
    path.sub_ext(((ext && !ext.empty?) ? ".#{ext}" : ""))
  end
  module_function :add_ext

  # Return the default workspace
  #
  # @param [Pathname] the default workspace
  def default_workspace
    Pathname(ENV["TMP"] || '/tmp').join("spaces")
  end
  module_function :default_workspace

  # Get the Engines workspace directory from the environment or use the default
  #
  # @param [Pathname] the workspace directory
  def workspace
    Pathname(ENV["ENGINES_WORKSPACE"] || default_workspace)
  end
  module_function :workspace
end
