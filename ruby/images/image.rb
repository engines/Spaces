require_relative '../spaces/model'
require_relative 'subject'

module Images
  class Image < ::Spaces::Model

    relation_accessor :subject

    def initialize(subject)
      self.subject = subject
    end

    def build
    end

  end
end
