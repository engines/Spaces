require_relative '../spaces/schema'
require_relative 'schema'

module Blueprints
  class ActiveSchema < ::Spaces::Schema
    extend Schema

  end
end
