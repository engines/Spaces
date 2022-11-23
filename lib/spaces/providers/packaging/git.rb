require_relative 'extractor'

module Packaging
  class Git < Extractor

    delegate(
      [:branch, :repository, :destination] => :state
    )

    def command =
      "git clone --depth 1 --branch #{branch} #{repository} #{destination}"

  end
end
