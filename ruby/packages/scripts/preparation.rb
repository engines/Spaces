require_relative '../../texts/one_time_script'

module Packages
  module Scripts
    class Preparation < Texts::OneTimeScript

      def body
        %Q(
        mkdir /#{product_path}
        cd /#{product_path}
        )
      end

    end
  end
end
