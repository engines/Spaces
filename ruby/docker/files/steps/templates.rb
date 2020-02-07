require_relative 'requires'

module Docker
  class File < ::Spaces::Product
    class Templates < Step

      def content
        '/scripts/install_templates.sh'
      end

    end
  end
end
