module Associations
  module Exotica

    def as_owncloud_trusted_names
      all.map do |a|
        "#{all.index(a)} => '#{a.name}'"
      end.join(", ")
    end

  end
end
