require_relative '../../texts/script'

module Replacements
  module Scripts
    class Sed < Texts::Script

      def body
        %Q(
        tmp_file=`mktemp`
        cat #{home_app_path}/#{source} | sed \"#{string}\" > $tmp_file
        cp $tmp_file #{home_app_path}/$destination
        rm $tmp_file
        )
      end

      delegate(
        descriptor: :context,
        [:string, :source, :destination ] => :descriptor
      )

    end
  end
end
