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
            anywhere: [:variables],
            last: [:bundle, :rake, :chown_app_dir, :finish]
          }
        end

        def inheritance_paths; [__dir__, super] ;end
      end

      require_files_in :steps, :scripts

      def user_name
        'ruby'
      end

      def default_port
        3000
      end

    end
  end
end
