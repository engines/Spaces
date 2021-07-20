require_relative 'aspect'

module ProviderAspects
  class ServiceTasks < Aspect

    delegate connect: :division

  end
end
