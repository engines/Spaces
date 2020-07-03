require_relative '../spaces/model'

module Releases
  class Component < ::Spaces::Model

    class << self
      def require_files_in(*folders)
        [*folders].each { |f| files_in(f).each { |f| require f } }
      end

      def files_in(folder)
        [inheritance_paths].flatten.map { |h| Dir["#{h}/#{folder}/*"] }.flatten
      end

      def inheritance_paths ;end
    end

    relation_accessor :stage

    delegate([:release, :home_app_path, :context_identifier] => :stage)

    def release_path; "release/#{script_path}" ;end

    def to_s; struct ;end

  end
end
