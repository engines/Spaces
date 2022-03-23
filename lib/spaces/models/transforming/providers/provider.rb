require_relative 'providers'
require_relative 'translating'

module Providers
  class Provider < ::Spaces::Model
    include ::Providers::Providers
    include Translating

    attr_accessor :role

    def initialize(role)
      self.role = role
    end

  end
end
