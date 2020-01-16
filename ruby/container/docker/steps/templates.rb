require_relative 'requires'

module Container
  module Docker
    class Templates < Step

      def content
        '/scripts/install_templates.sh'
      end

    end
  end
end
