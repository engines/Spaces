module Providers
  class Translator < ::Spaces::Model

    relation_accessor :adapter

    delegate(
      [:artifacts, :emission] => :adapter
    )

    def save_artifacts_to(path)
      artifacts.each do |a|
        path.join(a.filename).write(a.content)
      end
    end

    def initialize(adapter)
      self.adapter = adapter
    end

  end
end
