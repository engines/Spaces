module Divisions
  class Packing < ::Emissions::Division
    include ::Packing::Division

    class << self
      def script_choices(precedence)
        PN(__dir__).join("scripts", precedence).children
      end

      def script_choices_names(precedence)
        script_choices(precedence).map(&:basename_as_sym)
      end

      # FIXME: I think this is broken however I don't think it's ever called.
      # Broken in the sense that __dir__/scripts doesn't exist.
      #
      # Anyway this implementation will blow up because the __dir__/scripts doesn't
      # exist. Fail fast and all that!
      def precedence_choices
        PN(__dir__).join("scripts").children.map(&:basename_as_sym)
      end
    end

    def packing_stanza_for(precedence)
      {
        type: 'shell',
        inline: send(precedence).map do |s|
          temporary_script_path.join(sym_to_pathname(precedence), s)
        end
      }
    end

    def temporary_script_path
      PN("tmp").join("scripts")
    end

    def basename_as_sym(p)
      p.basename.to_s.to_sym
    end

  end
end
