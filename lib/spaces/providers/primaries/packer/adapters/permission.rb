module Providers
  module Packer
    class Permission < ::Adapters::Permission

      delegate [:recursion, :ownership, :file, :mode] => :division

      def snippets
        {
          type: 'shell',
          inline: [
            ("chown #{recursion} #{ownership} #{file}" if ownership),
            ("chmod #{recursion} #{mode} #{file}" if mode)
          ].compact
        }
      end

    end
  end
end
