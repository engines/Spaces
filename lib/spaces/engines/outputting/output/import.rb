module Spaces
  module Outputting
    class Import < Spaces::Outputting::Output

      def filepath
        @filepath ||= filepath_for(:publications, 'import.out')
      end

    end
  end
end
