require_relative '../framework'

module Frameworks
  module Python37
    class Python37 < Framework

      class << self
        def identifier
          'python37'
        end

        def user_name
          'python'
        end

        def step_precedence
          {
            anywhere: [:variables],
            last: [:configure, :chown_app_dir, :final]
          }
        end
        
        def inheritance_paths; [__dir__, super] ;end
      end

    end
  end
end
