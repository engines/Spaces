require_relative 'requires'

module Packages
  module Scripts
    class Preparation < Spaces::Script

      relation_accessor :package

      def body
        %Q(
        mkdir /#{image_space_path}
        cd /#{image_space_path}
        )
      end

    end
  end
end
