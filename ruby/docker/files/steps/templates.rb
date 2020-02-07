require_relative 'requires'

module Docker
  module Files
    class Templates < Step

      def content
        '/scripts/install_templates.sh'
      end

    end
  end
end
