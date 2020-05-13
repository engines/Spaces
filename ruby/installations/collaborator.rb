require_relative '../releases/collaborator'
require_relative '../texts/file_text'

module Installations
  class Collaborator < ::Releases::Collaborator

    alias_method :installation, :collaboration

    def text_class; Texts::FileText ;end

  end
end
