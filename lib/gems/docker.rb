# Monkey patch docker gem
#
# Define a new error class ImageNotFound for when image lookup fails.
#
# In the :extract_id method, throw this error instead of the generic
# UnexpectedResponseError.
#
# Spaces can then rescue ImageNotFound specifically.
require 'docker'
require 'gems/docker/error'
require 'gems/docker/util'
