module Divisions
  class ServiceTasks < ::Divisions::Division

    delegate connection_stanza_for: :provider_division_aspect

  end
end
