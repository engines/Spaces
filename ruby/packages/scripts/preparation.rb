require_relative '../../texts/script_once'

module Packages
  module Scripts
    class Preparation < Texts::ScriptOnce

      relation_accessor :package

      def body
        %Q(
        mkdir /#{build_script_path}
        cd /#{build_script_path}
        )
      end

    end
  end
end
