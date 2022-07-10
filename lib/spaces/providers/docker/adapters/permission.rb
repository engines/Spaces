module Adapters
  module Docker
    class Permission < ::Adapters::Permission

      delegate [:recursion, :ownership, :file, :mode] => :division

      def snippets = "RUN #{statements.join(connector)}"

      def statements =
        [
          ("chown #{recursion} #{ownership} #{file}" if ownership),
          ("chmod #{recursion} #{mode} #{file}" if mode)
        ].compact

      def connector = " &\&\\\n  "

    end
  end
end
