module Adapters
  module SystemDependencies

    def system_dependencies
      package_accessors.map do |a|
        send(a).map(&:system_dependencies) if declares?(a)
      end.flatten.compact
    end

    def package_accessors = [:bundled_packages, :managed_packages, :repositories]

  end
end
