require 'sinatra/base'

class ImageApi < Sinatra::Base

  get '/' do
    'HEEELLLLLLLOOOOO!!!'
  end

  run! if app_file == $0
end
