# frozen_string_literal: true

module Fs

  def PN(string)
    Pathname(string)
  end
  module_function :PN

  # Return the default workspace
  #
  # @param [Pathname] the default workspace
  def default_workspace
    PN(ENV["TMP"] || '/tmp').join("spaces")
  end
  module_function :default_workspace

  # Get the Engines workspace directory from the environment or use the default
  #
  # @param [Pathname] the workspace directory
  def workspace
    PN(ENV["ENGINES_WORKSPACE"] || default_workspace)
  end
  module_function :workspace
end
