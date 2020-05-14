require_relative '../step'

module Docker
  module Files
    module Steps
      class Runs < Step

        def instructions
          context.scripts.map { |s| "RUN #{s.full_path}" }
        end

      end
    end
  end
end
