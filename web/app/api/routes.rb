require './ruby/blueprints/controller'
require './ruby/resolutions/controller'

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

      put '/blueprints/:id/title' do
        Blueprints::Title::Controller.new(params).update.to_json
      end

      put '/blueprints/:id/description' do
        Blueprints::Description::Controller.new(params).update.to_json
      end

      put '/blueprints/:id/memory' do
        Blueprints::Memory::Controller.new(params).update.to_json
      end

      get '/blueprints/:blueprint_id/resolutions' do
        Blueprints::Resolutions::Controller.new(params).index.to_json
      end

      post '/blueprints/:blueprint_id/resolutions' do
        Blueprints::Resolutions::Controller.new(params).create.to_json
      end

      get '/resolutions' do
        Resolutions::Controller.new(params).index.to_json
      end

      get '/resolutions/:id' do
        Resolutions::Controller.new(params).show.to_json
      end

      delete '/resolutions/:id' do
        Resolutions::Controller.new(params).delete.to_json
      end

    end
  end
end
