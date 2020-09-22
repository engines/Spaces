require_relative '../releases/division'
require_relative '../defaultables/defaultable'

module Dns
  class Dns < ::Releases::Division
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
