module Associations
  module Exotica

    def as_owncloud_trusted_names
      (awpf = all_with_primary_first).map do |d|
        "#{awpf.index(d)} => '#{d.name}'"
      end.join(", ")
    end

  end
end
