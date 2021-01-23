require "rubygems"
require "bundler"
Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems
Dir.glob('./{app}/*.rb').each { |file| require file }

Mongoid.load! 'mongoid.config'
