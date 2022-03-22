require_relative 'providers'
require_relative 'adapting'

module Providers
  class Provider < ::Spaces::Model
    include ::Providers::Providers
    include Adapting

    attr_accessor :role

    def initialize(role)
      self.role = role
    end

  end
end
