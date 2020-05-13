require_relative '../spaces/model'
require_relative '../images/scripts'
require_relative '../docker/files/steps'

module Releases
  class Component < ::Spaces::Model
    include Images::Scripts
    include Docker::Files::Steps

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

      def inheritance_paths ;end
    end

    relation_accessor :collaboration

    delegate([:home_app_path, :context_identifier] => :collaboration)

    def release_path; "installation/#{script_path}" ;end

  end
end
