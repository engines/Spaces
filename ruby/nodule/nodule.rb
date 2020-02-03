require_relative '../spaces/model'
require_relative '../image/subject/collaboration'

module Nodule
  class Nodule < ::Spaces::Model
    include Image::Subject::Collaboration

    class << self
      def script_precedence
        @@nodule_script_precedence ||= [:installation]
      end
    end

    def identifier
      name
    end

  end
end
