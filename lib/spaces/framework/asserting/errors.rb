module Spaces
  module Errors
    class SpacesError < StandardError

      attr_reader :diagnostics

      def initialize(*args)
        super
        @diagnostics = {self.class.name => args}
      end
    end

    class FailedAssertion < SpacesError; end
    class MissingInput < SpacesError; end
    class IncorrectInputType < SpacesError; end
    class NoSpace < SpacesError; end
    class LostInSpace < SpacesError; end
    class ExistsInSpace < SpacesError; end
    class InterfaceError < SpacesError; end
    class ImportFailure < SpacesError; end
    class ReimportFailure < SpacesError; end
    class ExportFailure < SpacesError; end
    class CommandFail < SpacesError; end
    class NoInstruction < SpacesError; end
  end
end
