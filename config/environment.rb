require "rubygems"
require "bundler"
Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems
require './app/book_api.rb'
require './models/book.rb'
require './serializers/book_serializer.rb'

Mongoid.load! 'mongoid.config'
