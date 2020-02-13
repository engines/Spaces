require_relative '../../products/script_once'

module OsPackages
  module Scripts
    class Installation < Products::ScriptOnce

      def body
        "apt-get -y #{context.all.map { |a| a.name }.compact.uniq.join(' ')}"
      end

    end
  end
end
