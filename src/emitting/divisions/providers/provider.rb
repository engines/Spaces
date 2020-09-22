require_relative '../../emissions/subdivision'

module Providers
  class Provider < ::Emitting::Subdivision

    class << self
      def identifier; qualifier ;end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

  end
end
