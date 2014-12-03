require 'rails_helper'
require 'action_dispatch/testing/test_process'
describe CopyImage do
  subject { described_class }

  let(:image) { Image.new("base/path/IMG_0143") }
  # let(:upload_file) { { filename: "IMG_0143.jpg", type: "image/jpeg", name: "image", tempfile: File.open(Rails.root.join('spec/fixtures/testimage.jpg'), 'r') } }
  let(:upload_file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/testimage.jpg'), 'image/jpeg') }
  let(:root) { Rails.root }

  it "creates the correct path to save into" do
    expect(subject.new(upload_file, image).save_path).to eq("#{root}/public/images/base/path/original/IMG_0143.jpg")
  end

  it "copies the image from the temp file path its save spot" do
    upload_file # need because there is a File.open in this call
    expect_any_instance_of(described_class).to receive(:save_path).at_least(:once).and_return("/path")
    expect(File).to receive(:open).with("/path", "wb")

    described_class.call(upload_file, image)
  end


  it "returns the file_path the file will be copied to" do
    upload_file # needed because there is a File.open in it

    expect(File).to receive(:open).with(image.original_realpath, "wb")
    expect(described_class.call(upload_file, image)).to eq("#{root}/public/images/base/path/original/IMG_0143.jpg")
  end
end