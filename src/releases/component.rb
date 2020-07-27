require_relative '../spaces/model'
require_relative 'stanzas'

module Releases
  class Component < ::Spaces::Model
    include Stanzas

    class << self
      def stanza_lot
        files_in(:stanzas).map { |f| ::File.basename(f, '.rb') }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    relation_accessor :collaboration

    delegate([:release, :home_app_path, :context_identifier] => :collaboration)

    def release_path; "release/#{script_path}" ;end
    def declaratives
      stanzas.map(&:declaratives)
    end

    def to_s; struct ;end

  end
end
