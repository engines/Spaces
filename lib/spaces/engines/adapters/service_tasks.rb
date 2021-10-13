module Adapters
  class ServiceTasks < Adapter

    delegate connect: :division

  end
end
