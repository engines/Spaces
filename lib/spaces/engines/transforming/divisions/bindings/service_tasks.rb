module Divisions
  class ServiceTasks < ::Divisions::Division
    include RuntimeDefining

    delegate connection_stanza_for: :provider_aspect

  end
end
