# Monkey patch docker gem
#
# Define a new error class ImageNotFound for when image lookup fails.
#
# In the :extract_id method, throw this error instead of the generic
# UnexpectedResponseError.
#
# Spaces can then rescue ImageNotFound specifically.
require 'docker'

module Docker::Error
  class ImageNotFoundError < DockerError; end
end

module Docker::Util

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
