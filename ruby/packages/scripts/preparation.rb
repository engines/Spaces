require_relative '../../texts/one_time_script'

module Packages
  module Scripts
    class Preparation < Texts::OneTimeScript

      def body
        %Q(
        mkdir /#{path}
        cd /#{path}
        )
      end

    end
  end
end
