require_relative '../releases/division'
require_relative 'stanzas'

module Provisioning
  class Division < ::Releases::Division
    include Stanzas

    class << self
      def stanza_lot
        files_in(:stanzas).map { |f| ::File.basename(f, '.rb') }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    def declaratives
      stanzas.map(&:declaratives)
    end
  end
end
