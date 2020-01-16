require_relative '../spaces/model'
require_relative '../container/docker/layering'

module Environment
  class Environment < ::Spaces::Model
    include Container::Docker::Layering
    # The understanding of an executable inside an environment

    attr_reader *precedence
    attr_accessor :locale

    def variables
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
