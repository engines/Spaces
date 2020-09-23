require './src/blueprinting/controller'
require './src/resolving/controller'

module App
  class Api < Base
    module Routes
      extend Sinatra::Extension

      get '/blueprinting' do
        Blueprinting::Controller.new(params).index.to_json
      end

      post '/blueprinting' do
        Blueprinting::Controller.new(params).create.to_json
      end

      get '/blueprinting/:id' do
        Blueprinting::Controller.new(params).show.to_json
      end

      delete '/blueprinting/:id' do
        Blueprinting::Controller.new(params).delete.to_json
      end

      put '/blueprinting/:id/title' do
        Blueprinting::Title::Controller.new(params).update.to_json
      end

      put '/blueprinting/:id/description' do
        Blueprinting::Description::Controller.new(params).update.to_json
      end

      put '/blueprinting/:id/memory' do
        Blueprinting::Memory::Controller.new(params).update.to_json
      end

      get '/blueprinting/:id/resolution' do
        Resolving::Controller.new(params).show.to_json
      end

      post '/blueprinting/:id/resolution' do
        Resolving::Controller.new(params).create.to_json
      end

      delete '/blueprinting/:id/resolution' do
        Resolving::Controller.new(params).delete.to_json
      end

    end
  end
end
