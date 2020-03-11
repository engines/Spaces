require_relative 'requires'

module Docker
  module Files
    module Steps
      class Templates < Step

        def product
          '/scripts/install_templates.sh'
        end

      end
    end
  end
end
