require_relative '../terraform/division'

module Providers
  class Provider < ::Terraform::Division

    class << self
      def identifier; qualifier ;end

      def prototype(stage:, label:)
        universe.providers.by(stage)
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    def struct; @struct ||= stage.struct.provider ;end

  end
end
