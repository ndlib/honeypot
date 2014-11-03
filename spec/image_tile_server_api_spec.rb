require 'spec_helper'
require File.dirname(__FILE__) + '/../app/image_tile_server_api.rb'


describe "Image Tile Service" do

  def app
    ImageTileServerApi
  end

  describe "add_image" do
    it "puts to add_image and returns json of the post" do
      get '/add_image'
      #expect(last_response).to be_ok
      #expect(last_response.body).to include("HEEELLLLLLLOOOOO!!!")
    end
  end


  describe "#image" do
    let(:image) { Image.new('not/an/image.jpg')}

    it "returns json about the image " do
      #expect(image).to receive(:to_json).and_return("json")
      #expect_any_instance_of(ImageTileServerApi).to receive(:get_image).and_return(image)

      get "/image", { namespace: 'name/space', filename: 'filename.jpg'}

      #puts last_response.body
      #expect(last_response).to be_ok
      #expect(last_response.body).to include("json")
    end
  end

end

