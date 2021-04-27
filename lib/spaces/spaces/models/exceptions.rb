module Spaces
  module Errors
    class SpacesError < StandardError; end
    class MissingInput < SpacesError; end
    class NoSpace < SpacesError; end
    class LostInSpace < SpacesError; end
    class RepositoryFail < SpacesError; end
    class CommandFail < SpacesError; end
  end
end
