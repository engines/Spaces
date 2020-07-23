require_relative '../bridges/space'
require_relative '../provisioning/space'

module Containers
  class Space < ::Bridges::Space

    def bridge; @bridge ||= Provisioning::Space.new ;end

  end
end
