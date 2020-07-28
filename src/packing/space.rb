require 'packer'
require_relative '../spaces/space'
require_relative 'builders/space'

module Packing
  class Space < ::Spaces::Space

    alias_method :by, :by_json
    alias_method :save, :save_json

    def builders
      @builders ||= Builders::Space.new
    end

    protected

    def bridge
      @builder ||= Packer::Client.new
    end

  end
end
