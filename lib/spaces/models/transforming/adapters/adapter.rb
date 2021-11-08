require_relative 'precedence'

module Adapters
  class Adapter < ::Spaces::Model
    include Adapters::Precedence

  end
end
