require_relative '../collaborators/division'

module Starters
  class Starter < ::Collaborators::Division

    class << self
      def step_precedence
        { first: [:from, :adds] }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps

    def identifier; struct.identifier || image.gsub('/', '_') ;end
    def platform; struct.platform ;end

  end
end
