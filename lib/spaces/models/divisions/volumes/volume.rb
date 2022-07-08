module Divisions
  class Volume < ::Divisions::Subdivision

    class << self
      def features = [:type, :name, :destination]
    end

    alias_method :identifier, :context_identifier

    def source = "#{volume_path}/#{name}/#{identifier.as_path}"

    def mount? = type == default_type

    def type = struct.type || 'mount'
    def default_type = 'mount'

  end
end
