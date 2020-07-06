require_relative '../spaces/model'

module Releases
  class Component < ::Spaces::Model

    relation_accessor :stage

    delegate([:release, :home_app_path, :context_identifier] => :stage)

    def release_path; "release/#{script_path}" ;end

    def to_s; struct ;end

  end
end
