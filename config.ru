require 'rubygems'
require 'sinatra'
require "sinatra/json"


require './app/image_tile_server_api.rb'
run ImageTileServerApi
