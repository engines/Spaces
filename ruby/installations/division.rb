require_relative 'collaborator'

module Installations
  class Division < Collaborator

    class << self
      def step_precedence; end
      def script_lot; end
    end

    def scripts
      [super, all&.map(&:scripts)].flatten.compact.uniq(&:uniqueness)
    end

  end
end
