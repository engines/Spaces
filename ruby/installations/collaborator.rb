require_relative '../collaborators/collaborator'
require_relative '../texts/file_text'

module Installations
  class Collaborator < ::Collaborators::Collaborator

    alias_method :installation, :collaboration

    def text_class; Texts::FileText ;end

  end
end
