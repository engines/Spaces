module Providers
  class Packer < ::ProviderAspects::Provider
    class Permission < ::ProviderAspects::Permission

      delegate [:recursion, :ownership, :file, :mode] => :division

      def packing_artifact
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
