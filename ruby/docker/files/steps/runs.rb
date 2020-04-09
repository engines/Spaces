require_relative 'requires'

module Docker
  module Files
    module Steps
      class Runs < Step

        def product
          context.scripts.map { |s| "RUN #{s.path}" }
        end

      end
    end
  end
end
