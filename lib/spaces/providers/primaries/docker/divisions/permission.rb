module Providers
  module Docker
    class Permission < ::ProviderAspects::Permission

      delegate [:recursion, :ownership, :file, :mode] => :division

      def packing_stanza
        "RUN #{statements.join(connector)}"
      end

      def statements
        [
          ("chown #{recursion} #{ownership} #{file}" if ownership),
          ("chmod #{recursion} #{mode} #{file}" if mode)
        ].compact
      end

      def connector; " &\&\\\n  " ;end

    end
  end
end
