require_relative 'requires'

module Docker
  module Files
    module Steps
      class Templates < Step

        def product
          'RUN /scripts/injections.sh'
        end

      end
    end
  end
end
