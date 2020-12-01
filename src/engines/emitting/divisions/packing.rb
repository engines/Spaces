module Divisions
  class Packing < ::Emissions::KeyedDivision

    class << self
      def precedence; [:first, :early, :middle, :late, :last] ;end

      def script_choices(precedence)
        Pathname.glob("#{__dir__}/scripts/#{precedence}/*")
      end

      def script_choices_names(precedence)
        script_choices(precedence).map(&:basename).map(&:to_s).map(&:to_sym)
      end

      def precedence_choices
        Pathname.glob("#{__dir__}/scripts/*").map(&:basename).map(&:to_s).map(&:to_sym)
      end
    end

    def packing_stanza_for(key)
      {
        type: 'shell',
        scripts: ["#{packing_script_path}/#{key}"]
      }
    end

    def packing_script_path
      resolutions.file_path_for("packing/scripts/#{qualifier}", context_identifier)
    end

  end
end
