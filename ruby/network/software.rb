require_relative '../software/software'

module Network
  class Software < Software::Software

    attr_accessor :protocol

  end
end
