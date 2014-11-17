require "sinatra/config_file"
require File.join(File.dirname(__FILE__), 'add_image')
require File.join(File.dirname(__FILE__), '/image_json_formatter')

class ApiApplication < Sinatra::Base

  register Sinatra::ConfigFile
  set :environments, %w{development test pre_production production}

  config_file File.expand_path('../config/settings.yml', File.dirname(__FILE__))

  get '/' do
    params.inspect
  end

  get '/test' do
    erb :test
  end

  post '/images' do
    image = AddImage.call(params)
    json :image => ImageJsonFormatter.new(image)
  end

  get '/images/*' do
    puts params.inspect
    image = Image.find(params[:splat].first)
    json :image => ImageJsonFormatter.new(image)
  end

  run! if app_file == $0
end
