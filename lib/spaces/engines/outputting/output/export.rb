module Spaces
  module Outputting
    class Export < Spaces::Outputting::Output

      def filepath
        @filepath ||= filepath_for(:publications, 'export.out')
      end

    end
  end
end
