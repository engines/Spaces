require_relative '../terraform/division'

module Providers
  class Provider < ::Terraform::Division

    class << self
      def identifier; qualifier ;end

      def prototype(collaboration:, label:)
        universe.providers.by(collaboration)
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    def struct; @struct ||= collaboration.struct.provider ;end

  end
end
