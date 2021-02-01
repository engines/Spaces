module Resolving
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Resolution
      end
    end

    delegate(blueprints: :universe)

    def by(identifier, klass = default_model_class)
      by_yaml(identifier, klass).tap do |m|
        m.blueprint = blueprints.by(identifier)
      end
    rescue Errno::ENOENT => e
      warn(error: e, identifier: identifier, klass: klass)

      klass.new(blueprint: blueprints.by(identifier)).tap do |m|
        save(m)
      end
    end

    def save(model)
      ensure_connections_exist_for(model)
      super.tap do
        model.content.each { |t| save_text(t) }
      end
    end

    protected

    def ensure_connections_exist_for(model)
      model.connections.map do |c|
        c.with_embeds.resolved_in(model.arena)
      end.reject do |r|
        exist?(r)
      end.each { |r| save(r) }
    end

  end
end
