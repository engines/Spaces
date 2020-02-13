require_relative '../products/product'
require_relative 'collaboration'

module Images
  class Subject < ::Products::Product
    include Collaboration

    Dir["#{__dir__}/scripts/*/*"].each { |f| require f }

    class << self
      def script_collaborators
        @@subject_script_collaborators ||= [:framework, :os_packages, :nodules, :packages, :image_subject]
      end

      def script_precedence
        @@subject_script_precedence ||= [:build_functions,:finalisation,:chown_app_dir,:install_templates,:persistent_files,
          :persistent_dirs,:persistent_source,:recursive_write_permissions,:set_cont_user,:set_data_permissions,:write_permissions]
      end
    end

    def script_collaborators
      self.class.script_collaborators
    end

    def all_scripts
      script_collaborators.map { |c| tensor.send(c).scripts }.flatten.compact
    end

    def framework_build_script_path
      tensor.framework.build_script_path
    end

    def home_app_path
      '#{home_app_path}'
    end
  end
end
