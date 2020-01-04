require_relative '../spaces/model'

module Environment
  class Environment < ::Spaces::Model
    # The understanding of an executable inside an environment

    attr_accessor :locale

    def locale_layers
      %Q(
        ENV LANGUAGE '#{locale.language}'
        ENV LANG '#{locale.lang}'
        ENV LC_ALL '#{locale.lc_all}'
      )
    end

    def locale
      @locale ||= struct.locale
    end

  end
end
