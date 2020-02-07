require_relative '../spaces/product'
require_relative 'subjects/collaboration'

module Images
  class Subject < ::Spaces::Product
    include Collaboration

    Dir["#{__dir__}/subjects/scripts/*"].each { |f| require f }

    class << self
      def script_collaborators
        @@subject_script_collaborators ||= [:os_packages, :nodules, :packages]
      end
    end

    def script_collaborators
      self.class.script_collaborators
    end

    def scripts
      script_collaborators.map { |c| tensor.send(c).scripts }.flatten.compact
    end

  end
end
