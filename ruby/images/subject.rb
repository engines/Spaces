require_relative '../collaborators/collaborator'

module Images
  class Subject < ::Collaborators::Collaborator

    Dir["#{__dir__}/scripts/*/*"].each { |f| require f }

    class << self
      def script_collaborators
        @@subject_script_collaborators ||= [:framework, :os_packages, :nodules, :packages, :image_subject]
      end

      def script_precedence
        @@subject_script_precedence ||= [:finalisation]
      end
    end

    def script_collaborators
      self.class.script_collaborators
    end

    def reduced_scripts
      all_scripts.uniq{ |s| s.uniqueness } 
    end

    def all_scripts
      collaborators.map { |c| c.scripts }.flatten.compact
    end

    def collaborators
      script_collaborators.map { |c| tensor.send(c) }.compact
    end

    def home_app_path
      '/home/app'
    end
  end
end
