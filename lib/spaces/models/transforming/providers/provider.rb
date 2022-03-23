require_relative 'providers'
require_relative 'translating'
require_relative 'interfacing'

module Providers
  class Provider < ::Spaces::Model
    include ::Providers::Providers
    include Translating
    include Interfacing

    attr_accessor :role

    def initialize(role)
      self.role = role
    end

  end
end
