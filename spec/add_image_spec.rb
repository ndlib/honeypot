require 'spec_helper'

require File.dirname(__FILE__) + '/../app/add_image.rb'

describe AddImage do
  let(:params) { { namespace: 'path/1/1', image: { filename: 'filename.jpg' } } }

  it "validates that there is a namespace set "

  it "validates that there is an image set"

  it "returns false if the upload does not work"

  it "takes the params and copies the image to the saved image directory" do
    expect_any_instance_of(described_class).to receive(:convert_image)

    expect(CopyImage).to receive(:call).with(params[:image], params[:namespace])
    AddImage.call(params)
  end

  it "takes the params and converts the image have the image tiling" do
    expect_any_instance_of(described_class).to receive(:copy_image)

    expect(ConvertImage).to receive(:call)
    AddImage.call(params)
  end

  it "returns the current image"

end
