require 'spec_helper'

require File.dirname(__FILE__) + '/../app/copy_image.rb'

describe CopyImage do
  subject { described_class }

  let(:base_path) { "base/path" }
  let(:upload_file) { { filename: "IMG_0143.jpg", type: "image/jpeg", name: "image", tempfile: File.open(File.join(File.dirname(__FILE__), 'fixtures/testimage.jpg'), 'r') } }

  it "creates the correct path to save into" do
    expect(subject.new(upload_file, base_path).save_path).to eq("/Users/jhartzle/Workspace/honeypot/app/../system/saved_files/base/path/IMG_0143.jpg")
  end

  it "copies the image from the temp file path its save spot" do
    upload_file # need because there is a File.open in this call
    expect_any_instance_of(described_class).to receive(:save_path).and_return("/path")
    expect(File).to receive(:open).with("/path", "wb")

    described_class.call(upload_file, base_path)
  end


  it "returns the file_path the file will be copied to" do
    upload_file # needed because there is a File.open in it

    expect_any_instance_of(described_class).to receive(:save_path).and_return("/path")
    expect(File).to receive(:open).with("/path", "wb")

    expect(described_class.call(upload_file, base_path)).to eq("/system/saved_files/base/path/IMG_0143.jpg")
  end
end
