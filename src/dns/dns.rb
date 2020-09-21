require_relative '../spaces/defaultables/defaultable'
require_relative '../emitting/emissions/division'

module Dns
  class Dns < ::Emitting::Division
    include Defaultables::Defaultable

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    def default
      OpenStruct.new(type: :power_dns)
    end

  end
end
