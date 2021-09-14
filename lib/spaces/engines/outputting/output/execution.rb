module Spaces
  module Outputting
    class Execution < Spaces::Outputting::Output

      def filepath
        @filepath ||= filepath_for(:arenas, identifier, 'execution.out')
      end

    end
  end
end
