module Divisions
  class ServiceTasks < ::Divisions::Division

    delegate connection_snippet_for: :provider_division_aspect

  end
end
