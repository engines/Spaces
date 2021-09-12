module Spaces
  module Outputting
    class Build < Spaces::Outputting::Output

      def filepath
        @filepath ||= filepath_for(:packing, *identifier.split('::'), 'build.out')
      end

    end
  end
end
