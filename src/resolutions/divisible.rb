require_relative '../releases/divisible'
require_relative '../texts/file_text'

module Resolutions
  class Divisible < ::Releases::Divisible

    alias_method :resolution, :division

    def text_class; Texts::FileText ;end

  end
end
