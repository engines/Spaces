module Adapters
  class Repositories < Divisible

    class << self
      def subadapter_class = Repository
    end

    delegate(subadapter_class: :klass)

    def subadapter_for(subdivision) =
      subadapter_class.dynamic_type(subdivision, self)

  end
end
