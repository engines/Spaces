require_relative '../spaces/model'
require_relative '../images/production'
require_relative '../docker/files/production'

module Installations
  class Production < ::Spaces::Model
    include Images::Production
    include Docker::Files::Production

    class << self
      def step_precedence
        { anywhere: files_in(:steps).map { |f| File.basename(f, '.rb') } }
      end

      def script_lot
        files_in(:scripts).map { |f| File.basename(f, '.rb') }
      end

      def require_files_in(*folders)
        [*folders].each { |f| files_in(f).each { |f| require f } }
      end

      def files_in(folder)
        [inheritance_paths].flatten.map { |h| Dir["#{h}/#{folder}/*"] }.flatten
      end

      def inheritance_paths; end
    end

    alias_method :production_build_script_path, :build_script_path

    def product
      duplicate(struct)
    end

  end
end
