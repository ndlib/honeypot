require 'sinatra/base'

class ImageTileServerApi < Sinatra::Base

  get '/' do
    'HEEELLLLLLLOOOOO!!!'
  end

  run! if app_file == $0
end
