require 'spec_helper'
require File.dirname(__FILE__) + '/../app/image_tile_server_api.rb'


describe "Image Tile Service" do

  def app
    ImageTileServerApi
  end


  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("HEEELLLLLLLOOOOO!!!")
  end
end

