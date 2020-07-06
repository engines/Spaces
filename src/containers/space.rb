require_relative '../bridges/space'
require_relative '../terraform/space'

module Containers
  class Space < ::Bridges::Space

    def bridge; @bridge ||= Terraform::Space.new ;end

  end
end
