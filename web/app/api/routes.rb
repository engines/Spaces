require './ruby/blueprints/controller'
require './ruby/installations/controller'

module App
  class Api < Base
    module Routes
      extend Sinatra::Extension

      get '/blueprints' do
        Blueprints::Controller.new(params).index.to_json
      end

      post '/blueprints' do
        Blueprints::Controller.new(params).create.to_json
      end

      get '/blueprints/:id' do
        Blueprints::Controller.new(params).show.to_json
      end

      delete '/blueprints/:id' do
        Blueprints::Controller.new(params).delete.to_json
      end

      get '/blueprints/:blueprint_id/installations' do
        Blueprints::Installations::Controller.new(params).index.to_json
      end

      post '/blueprints/:blueprint_id/installations' do
        Blueprints::Installations::Controller.new(params).create.to_json
      end

      get '/installations' do
        Installations::Controller.new(params).index.to_json
      end

      get '/installations/:id' do
        Installations::Controller.new(params).show.to_json
      end

      delete '/installations/:id' do
        Installations::Controller.new(params).delete.to_json
      end

    end
  end
end
