require 'spec_helper'

require File.dirname(__FILE__) + '/../app/convert_image.rb'


describe ConvertImage do
  subject { described_class.new(image) }

  let(:image) { Image.new('path/1/1/filename.jpg')}

  it "calls a command line to convert the image" do
    expect_any_instance_of(described_class).to receive(:command).and_return("echo 'hi'")
    described_class.call(image)
  end

  it "calls the correct command line entry"  do
    expect(subject.send(:command)).to eq("vips im_vips2tiff /Users/jhartzle/Workspace/honeypot/app/../system/saved_files/path/1/1/original/filename.jpg /Users/jhartzle/Workspace/honeypot/app/../system/saved_files/path/1/1/filename.tif:jpeg:80,tile:256x256,pyramid")
  end

end
