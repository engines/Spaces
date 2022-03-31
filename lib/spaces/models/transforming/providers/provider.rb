require_relative 'providers'
require_relative 'translating'
require_relative 'interfacing'

module Providers
  class Provider < ::Spaces::Model
    include ::Providers::Providers
    include Translating
    include Interfacing

    class << self
      alias_method :application_qualifiers, :subqualifiers
    end

    def name; identifier ;end

    def identifier; struct[:identifier] ;end

    def initialize(struct: nil, identifiable: nil)
      super(struct: struct)
      self.struct.identifier = identifiable.identifier if identifiable
    end

  end
end
