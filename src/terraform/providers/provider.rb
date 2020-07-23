require_relative '../division'

module Terraform
  module Providers
    class Provider < Division

      class << self
        def identifier; qualifier ;end

        def prototype(collaboration:, label:)
          universe.terraform.providers.by(collaboration)
        end

        def inheritance_paths; __dir__ ;end
      end

      require_files_in :stanzas

      def struct; @struct ||= collaboration.struct.provider ;end

    end
  end
end
