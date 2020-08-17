require_relative '../../releases/subdivision'

module Provisioning
  module Containers
    class Container < ::Releases::Subdivision

      class << self
        def qualifier
          name.split('::').last.downcase
        end
      end

    end
  end
end
