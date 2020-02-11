require_relative '../products/product'
require_relative 'collaboration'

module Images
  class Subject < ::Products::Product
    include Collaboration

    class << self
      def script_collaborators
        @@subject_script_collaborators ||= [:framework, :os_packages, :nodules, :packages, :image_subject]
      end

      def script_precedence
        @@subject_script_precedence ||= [] # JAMES: put your script class syblos here!
      end
    end

    def script_collaborators
      self.class.script_collaborators
    end

    def all_scripts
      script_collaborators.map { |c| tensor.send(c).scripts }.flatten.compact
    end

  end
end
