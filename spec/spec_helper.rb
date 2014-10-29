require 'rubygems'
require 'bundler'

require 'sinatra'
require 'rack/test'

set :environment, :test


RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
