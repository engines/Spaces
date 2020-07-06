require_relative '../releases/division'

module Frameworks
  class Framework < ::Releases::Division

    class << self
      def prototype(stage:, label:)
        universe.frameworks.by(stage)
      end
    end

    def port; @port ||= struct.port || default_port ;end
    def default_port; 8000 ;end

    def user_name; 'www-data' ;end

    def release_path; "#{super}/#{klass.identifier}" ;end

    def struct; @struct ||= stage.struct.framework ;end

  end
end
