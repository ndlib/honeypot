require 'rails_helper'
require 'action_dispatch/testing/test_process'
describe CopyImage do
  subject { described_class.new(upload_file, image_set) }

  let(:relative_path) {"test/copyimage/IMG_0143.jpg"}
  let(:image_set) { ImageSet.new(relative_path) }
  let(:upload_file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/testimage.jpg'), 'image/jpeg') }
  let(:image_root) { Rails.root.join("public/images") }

  it "creates the correct path to save into" do
    expect(subject.save_path).to eq(File.join(image_root, relative_path))
  end

  describe '#verify_directory' do
    let(:test_directory) { File.dirname(File.join(image_root, relative_path)) }
    before do
      expect(test_directory).to match(/copyimage/)
      FileUtils.rm_rf(test_directory)
    end

    it 'creates the containing directory if it does not exist' do
      expect(File.exists?(test_directory)).to be_falsy
      subject.send(:verify_directory)
      expect(File.exists?(test_directory)).to be_truthy
    end

    after do
      FileUtils.rm_rf(test_directory)
    end
  end

  describe 'self' do
    subject { described_class }

    it "copies the image from the temp file path its save spot" do
      upload_file # need because there is a File.open in this call
      expect_any_instance_of(described_class).to receive(:save_path).at_least(:once).and_return("/path")
      expect(File).to receive(:open).with("/path", "wb")

      subject.call(upload_file, image_set)
    end

    it "returns the file_path the file will be copied to" do
      upload_file # needed because there is a File.open in it

      expect(File).to receive(:open).with(image_set.original_filepath, "wb")
      expect(subject.call(upload_file, image_set)).to eq(File.join(image_root, relative_path))
    end
  end
end
