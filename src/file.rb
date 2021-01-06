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

end
