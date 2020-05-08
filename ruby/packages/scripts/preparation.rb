require_relative '../../texts/one_time_script'

module Packages
  module Scripts
    class Preparation < Texts::OneTimeScript

      def body
        %Q(
        mkdir /#{installation_path}
        cd /#{installation_path}
        )
      end

    end
  end
end
