require 'spec_helper'

require File.dirname(__FILE__) + '/../app/add_image.rb'

describe AddImage do
  let(:params) { { namespace: 'path/1/1', image: { filename: 'filename.jpg' } } }

  it "validates that there is a namespace set "

  it "validates that there is an image set"

  it "returns false if the upload does not work"

  it "takes the params and copies the image to the saved image directory" do
    expect(CopyImage).to receive(:call).with(params[:image], params[:namespace])
    AddImage.call(params)
  end

  it "takes the params and converts the image have the image tiling"

  it "returns the current image"

end
