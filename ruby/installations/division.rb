require_relative '../releases/division'
require_relative '../texts/file_text'

module Installations
  class Division < ::Releases::Division

    alias_method :installation, :collaboration

    def text_class; Texts::FileText ;end

  end
end
