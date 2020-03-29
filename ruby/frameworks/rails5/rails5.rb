require_relative '../framework'

module Frameworks
  module Rails5
    class Rails5 < Framework

      class << self
        def identifier
          'rails5'
        end

        def step_precedence
          {
            first: [:from_image],
            anywhere: [:variables],
            last:  [:bundle, :rake_tasks]
          }
        end

        def inheritance_paths; [__dir__, super]; end
      end

      require_files_in :steps, :scripts

      def user_identifier
        'ruby'
      end

      def default_port
        3000
      end

    end
  end
end
