require_relative '../releases/component'
require_relative '../defaultables/defaultable'

module ServiceNetworking
  class ServiceNetwork < ::Releases::Component
    include Defaultables::Defaultable

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    def default
      OpenStruct.new(type: :consul)
    end

  end
end
