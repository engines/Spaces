require_relative '../framework'

module Frameworks
  module Python37
    class Python37 < Framework

      class << self
        def identifier
          'python37'
        end

        def user_identifier
          'python'
        end

        def step_precedence
          {
            first: [:from_image],
            anywhere: [:variables],
            last: [:configure]
          }
        end

        def inheritance_paths; [__dir__, super]; end
      end

      require_files_in :steps, :scripts

    end
  end
end
