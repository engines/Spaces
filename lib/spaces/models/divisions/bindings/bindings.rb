module Divisions
  class Bindings < ::Targeting::Bindings

    def deep_connect_bindings
      deep_bindings.reject { |b| b.embed? || b.binder? }
    end

    def deep_binder_bindings
      deep_bindings.select(&:binder?)
    end

  end
end
