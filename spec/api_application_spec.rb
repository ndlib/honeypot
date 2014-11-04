require 'spec_helper'
require File.dirname(__FILE__) + '/../app/api_application.rb'


describe "Image Tile Service" do

  def app
    ApiApplication
  end

  describe "add_image" do
    it "puts to add_image and returns json of the post" do
      get '/add_image'
      #expect(last_response).to be_ok
      #expect(last_response.body).to include("HEEELLLLLLLOOOOO!!!")
    end
  end


  describe "#image" do
    let(:image) { double(Image, width: 1000, height: 1000, type: 'image/jpg', path: 'path', uri: 'uri')}

    it "returns json about the image " do
      expect_any_instance_of(Image).to receive(:find).and_return(image)

      get "/", { namespace: 'name/space', filename: 'filename.jpg' }

      expect(last_response).to be_ok
      expect(last_response.body).to include("json")
    end
  end

end

