require 'rails_helper'

describe ImageSet do
  subject { described_class.new(filepath) }
  let(:base_full_filepath) { File.join(Rails.root, 'public/images', path) }
  let(:path) { '/test/000/001/000/002' }
  let(:filename) { 'testimage.jpg' }
  let(:filepath) { File.join(path, filename) }
  let(:fixture_directory) { File.join(Rails.root, 'spec/fixtures') }
  let(:fixture_filepath) { File.join(fixture_directory, 'testimage.jpg') }

  it "returns the original_filepath" do
    expect(subject.send(:original_filepath)).to eq("#{base_full_filepath}/testimage.jpg")
  end

  it "returns a derivative filepath" do
    expect(subject.derivative_filepath(:small)).to eq("#{base_full_filepath}/small/testimage.jpg")
  end

  it "returns the pyramid_filepath" do
    expect(subject.pyramid_filepath).to eq("#{base_full_filepath}/pyramid/testimage.tif")
  end

  describe '#exists?' do
    it "returns true when the original file exists" do
      expect(subject.original).to receive(:filepath).and_return(fixture_filepath)
      expect(subject.exists?).to be_truthy
    end

    it "returns false when the file is not present" do
      expect(subject.exists?).to be_falsy
    end
  end

  describe '#derivative_filepaths' do
    describe 'real files' do
      subject { described_class.new('testimage.jpg') }
      let(:styles) { [:large, :small] }
      before do
        allow(subject).to receive(:base_full_filepath).and_return(fixture_directory)
        styles.each do |style|
          derivative_filepath = subject.derivative_filepath(style)
          FileUtils.mkdir_p(File.dirname(derivative_filepath))
          FileUtils.touch(derivative_filepath)
        end
      end

      after do
        styles.each do |style|
          derivative_filepath = subject.derivative_filepath(style)
          File.delete(derivative_filepath)
          Dir.rmdir(File.dirname(derivative_filepath))
        end
      end

      it "returns file paths" do
        expected_paths = styles.collect{|style| subject.derivative_filepath(style)}
        expect(subject.send(:derivative_filepaths)).to eq(expected_paths)
      end
    end
  end

  describe 'self' do
    subject { described_class }
    describe '#find' do
      it "raises an error if the image file is not present" do
        expect{subject.find('fakeimage.jpg')}.to raise_error(Image::ImageNotFound)
      end

      it "returns an ImageSet if the image file is present" do
        expect_any_instance_of(described_class).to receive(:exists?).and_return(true)
        expect(subject.find('foundimage.jpg')).to be_a_kind_of(described_class)
      end
    end
  end

end
