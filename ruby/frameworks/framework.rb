require_relative '../releases/division'

module Frameworks
  class Framework < ::Releases::Division

    class << self
      def prototype(stage:, label:)
        universe.frameworks.by(stage)
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps, :scripts

    def port; @port ||= struct.port || default_port ;end
    def default_port; 8000 ;end

    def data_uid; stage.user.data_uid ;end
    def data_gid; stage.user.data_gid ;end
    def user_name; 'www-data' ;end

    def release_path; "#{super}/#{klass.identifier}" ;end

    def struct; @struct ||= stage.struct.framework ;end

  end
end
