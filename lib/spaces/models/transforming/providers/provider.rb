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

    attr_accessor :role

    def initialize(role)
      self.role = role
    end

  end
end
