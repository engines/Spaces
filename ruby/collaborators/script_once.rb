require_relative 'script'

module Collaborators
  class ScriptOnce < Script

    def identifier
      qualifier
    end

  end
end
