require_relative 'stream'
require_relative 'producing'
require_relative 'consuming'
require_relative 'writing'

module Streaming
  class FileStream < Stream
    include Producing
    include Consuming
    include Writing

    delegate(
      streaming: :universe,
      path: :streaming,
      [:dirname, :basename] => :path
    )

    def eot = 4.chr

  end
end
