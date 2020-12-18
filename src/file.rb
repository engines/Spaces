# frozen_string_literal: true

module Fs

  def PN(string)
    Pathname(string)
  end
  module_function :PN

  # Return the default workspace
  #
  # @param [Pathname] the default workspace
  def workspace
    PN('/opt/spaces')
  end
  module_function :workspace
end
