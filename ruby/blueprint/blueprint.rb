require_relative '../engines/model'
require_relative '../software/version'
require_relative '../executable/tensor'
require_relative '../container/tensor'
require_relative '../software/tensor'
require_relative '../image/tensor'

module Blueprint
  class Blueprint < Engines::Model
    # A plan for making software executable and usable, potentially many times over

    relation_accessor :software_version,
      :executable_tensor,
      :container_tensor,
      :software_tensor,
      :image_tensor,
      :dependencies,
      :pages

  end
end
