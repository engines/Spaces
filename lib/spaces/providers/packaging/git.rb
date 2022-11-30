require_relative 'extractor'

module Packaging
  class Git < Extractor

    class << self
      def system_dependencies = [:git]
    end

    delegate(
      [:branch, :repository, :destination] => :state
    )

    def command =
      "git clone --depth 1 --branch #{branch} #{repository} #{destination}"

  end
end
