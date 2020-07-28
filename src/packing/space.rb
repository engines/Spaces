require 'packer'
require_relative '../spaces/space'
require_relative 'builders/space'

module Packing
  class Space < ::Spaces::Space

    def builders
      @builders ||= Builders::Space.new
    end

  end
end
