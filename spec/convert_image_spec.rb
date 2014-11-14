require 'spec_helper'

require File.dirname(__FILE__) + '/../app/convert_image.rb'


describe ConvertImage do
  subject { described_class.new(image) }

  let(:image_path) { 'path/1/1' }
  let(:image) { Image.new("#{image_path}/filename.jpg") }
  let(:root) { File.expand_path('..', File.dirname(__FILE__)) }

  it "calls a command line to convert the image" do
    expect_any_instance_of(described_class).to receive(:command).and_return("echo 'hi'")
    described_class.call(image)
  end

  it "calls the correct command line entry"  do
    expect(subject.send(:command)).to eq("vips im_vips2tiff #{root}/public/images/#{image_path}/original/filename.jpg #{root}/public/images/#{image_path}/filename.tif:jpeg:80,tile:256x256,pyramid")
  end

end
