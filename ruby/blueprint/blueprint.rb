require_relative '../framework/model'
require_relative '../software/version'
require_relative '../executable/tensor'
require_relative '../container/tensor'
require_relative '../software/tensor'
require_relative '../image/tensor'
require_relative '../universal/descriptor'

module Blueprint
  class Blueprint < ::Framework::Model
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
