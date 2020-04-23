require './ruby/blueprints/controller'
require './ruby/installations/controller'

module App
  class Api < Base
    module Routes
      extend Sinatra::Extension

      get '/blueprints' do
        Blueprints::Controller.new(params).index
      end

      post '/blueprints' do
        Blueprints::Controller.new(params).create
      end

      get '/blueprints/:id' do
        Blueprints::Controller.new(params).show
      end

      delete '/blueprints/:id' do
        Blueprints::Controller.new(params).delete
      end

      get '/blueprints/:blueprint_id/installations' do
        Blueprints::Installations::Controller.new(params).index
      end

      post '/blueprints/:blueprint_id/installations' do
        Blueprints::Installations::Controller.new(params).create
      end

      get '/installations' do
        Installations::Controller.new(params).index
      end

      get '/installations/:id' do
        Installations::Controller.new(params).show
      end

      delete '/installations/:id' do
        Installations::Controller.new(params).delete
      end

    end
  end
end
