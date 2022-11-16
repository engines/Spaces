module Divisions
  module Dividing

    def incomplete_divisions = divisions.reject(&:complete?)

    def role_providers = important_division_for(:role_providers)
    def connections = important_division_for(:connections)

    def input = important_division_for(:input)
    def configuration = important_division_for(:configuration)
    def bindings = important_division_for(:bindings)
    def binding_target = important_division_for(:binding_target)
    def images = important_division_for(:images)
    def volumes = important_division_for(:volumes)
    def resources = important_division_for(:resources)

    def important_division_for(key) =
      has?(key) ? division_map[key] : division_for(key)

    def division_map
      @division_map ||= keys.inject({}) do |m, k|
        m.tap { m[k] = division_for(k) }
      end.compact
    end

    def divisions = division_map.values
    def division_keys = division_map.keys

    def division_for(key) =
      associations_and_divisions[key]&.dynamic_type(emission: self, label: key)

  end
end
