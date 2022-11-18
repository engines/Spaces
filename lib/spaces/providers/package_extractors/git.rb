require_relative 'extractor'

module PackageExtractors
  class Git < Extractor

    delegate(
      [:target, :repository, :destination] => :adapter,
      branch: :target
    )

    def command =
      "git clone --depth 1 --branch #{branch} #{repository} #{destination}"

  end
end
