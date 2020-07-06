require_relative '../releases/division'
require_relative '../texts/file_text'

module Resolutions
  class Division < ::Releases::Division

    alias_method :resolution, :stage

    def text_class; Texts::FileText ;end

  end
end
