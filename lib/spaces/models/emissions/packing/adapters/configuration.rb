module Adapters
  module PackConfiguration

    def configure_repositories
      if declares?(:repositories)
        repositories.each(&:configure)
      end
    end

    def clean_repository_configurations
      if declares?(:repositories)
        repositories.each(&:clean)
      end
    end

  end
end
