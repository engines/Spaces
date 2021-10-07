module Adapters
  class ServiceTasks < DivisionAdapter

    delegate connect: :division

  end
end
