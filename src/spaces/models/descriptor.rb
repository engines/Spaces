require 'addressable/uri'

require_relative 'model'

module Spaces
  class Descriptor < Model

    delegate(
      identifier: :struct,
      [:basename, :extname] => :repository
    )

    attr_accessor :repository

    def root_identifier = basename.split('.').first

    def branch = struct.branch ||= 'main'
    def protocol = struct.protocol ||= extname&.gsub('.', '')
    def git? = protocol == 'git'

    def initialize(args)
      self.repository = Addressable::URI.parse(args[:repository])

      self.struct = args[:struct] || OpenStruct.new(args)
      self.struct.identifier ||= root_identifier
    end

    def to_s = [repository, branch, identifier].compact.join(' ')

  end
end
