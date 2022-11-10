module Adapters
  module Git
    class BundledPackage < ::Adapters::BundledPackage

      def command =
        "git clone #{repository} #{destination}"

    end
  end
end
