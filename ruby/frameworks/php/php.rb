require_relative '../framework'

module Frameworks
  module PHP
    class PHP < Framework

      class << self
        def identifier
          'php'
        end

        def step_precedence
          {
            first: [:from_image],
            anywhere: [:variables]
          }
        end

        def inheritance_paths
          [__dir__, super]
        end
      end

      require_files_in :steps

    end
  end
end
