require_relative 'repository'

module Divisions
  class Repositories < ::Divisions::Divisible

    class << self
      def subdivision_class = Repository
    end

    delegate(subdivision_class: :klass)

  end
end
