# TEMPORARY FIX: to escape 'uninitialized constant Adapters::DockerCompose::Orchestration'

module Adapters
  module DockerCompose
    class Orchestration < ::Adapters::Orchestration

            # TODO: REFACTOR -- this kludge exists, because orchestration assumes
            # there will be an orchestration adapter which, in the case of Docker Compose,
            # does not seem to apply. It looks like Docker Compose will rely entirely
            # on its arena adapter to generate a single artifact under the arena.
            # They may be other orchestraters that employ a similar strategy.
            # THEREFORE, providers need to contain a dynamic adapter(or adapter-class)
            # map to signal what adapters are required for it.


      def artifact_qualifiers = []

    end
  end
end
