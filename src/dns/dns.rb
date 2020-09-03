require_relative '../releases/component'
require_relative '../defaultables/defaultable'

module Dns
  class Dns < ::Releases::Component
    include Defaultables::Defaultable

    class << self
      def qualifier
        name.split('::').last.downcase
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas
    
    def default
      OpenStruct.new(type: :power_dns)
    end

  end
end
