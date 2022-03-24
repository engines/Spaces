module Resolving
  module Podding

    def to_pod
      empty_pod.tap do |m|
        m.struct.identifier = identifier
        m.cache_primary_identifiers
      end
    end

    def empty_pod; pod_class.new ;end
    def pod_class; ::Pods::Pod ;end

  end
end
