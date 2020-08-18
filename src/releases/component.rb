require_relative '../spaces/model'
require_relative 'stanzas'

module Releases
  class Component < ::Spaces::Model
    include Stanzas

    attr_accessor :label

    class << self
      def prototype(collaboration:, label:)
        new(collaboration: collaboration, label: label)
      end

      def stanza_lot
        files_in(:stanzas).map { |f| ::File.basename(f, '.rb') }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    relation_accessor :collaboration

    delegate([:release, :home_app_path, :context_identifier] => :collaboration)

    def declaratives
      stanzas.map(&:declaratives)
    end

    def initialize(struct: nil, collaboration: nil, label: nil)
      self.collaboration = collaboration
      self.label = label
      self.struct = struct || collaboration&.struct[label] || default
    end

    def to_s; struct ;end

  end
end
