# TEMPORARY FIX: to escape 'uninitialized constant Adapters::DockerCompose::Provisions'

module Adapters
  module DockerCompose
    class Provisions < ::Adapters::Provisions

            # TODO: REFACTOR -- this kludge exists, because provisioning assumes
            # there will be a provisions adapter which, in the case of Docker Compose,
            # does not seem to apply. It looks like Docker Composes will rely entirely
            # on it arena adapter to genereate a single artifact under the arena.
            # They may be other provisioners that employ a similar strategy.
            # THEREFORE, providers need to contain a dynamic adapter(or adapter-class)
            # map to signal what adapters are required for it.


      def artifact_qualifiers
        []
      end

    end
  end
end
