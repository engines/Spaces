module Divisions
  class Git < BundledPackage

    delegate(branch: :target)

    def command =
      "git clone --depth 1 --branch #{branch} #{repository} #{destination}"

  end
end
