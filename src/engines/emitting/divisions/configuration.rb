module Divisions
  class Configuration < ::Emissions::Division
    include Emissions::Resolvable

      def resolved
        @resolved ||= OpenStruct.new(resolved_texts)
      end

  end
end
