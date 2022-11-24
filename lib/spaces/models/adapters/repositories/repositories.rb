module Adapters
  class Repositories < Divisible

    class << self
      def subadapter_class = Repository
    end

    delegate(subadapter_class: :klass)

  end
end
