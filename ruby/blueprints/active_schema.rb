require_relative '../spaces/schema'

module Blueprints
  class ActiveSchema < :: Spaces::Schema
    extend Schema

    delegate(outline: :klass)
  end
end
