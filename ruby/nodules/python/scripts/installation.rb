require_relative '../../../spaces/script'

module Nodules
  class Python
    class Installation < Spaces::Script

      def body
        "python${python_version} -m pip install --upgrade #{context.name}"
      end

    end
  end
end
