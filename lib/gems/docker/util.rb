module Docker
  module Util

    alias_method :original_extract_id, :extract_id

    module_function :original_extract_id

    def extract_id(body)
      begin
        original_extract_id(body)
      rescue UnexpectedResponseError => e
        raise ImageNotFoundError
      end
    end

    module_function :extract_id

  end
end
