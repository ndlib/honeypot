require 'rails_helper'

describe ImageSet do
  subject { described_class.new(filepath) }
  let(:image_root) { File.join(Rails.root, 'public/images') }
  let(:base_full_filepath) { File.join(image_root, path) }
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

  it "returns a thumbnail filepath" do
    expect(subject.thumbnail_filepath(:small)).to eq("#{base_full_filepath}/small/testimage.jpg")
  end

  describe 'gif' do
    let(:filename) { 'testgif.gif' }
    it "returns a thumbnail filepath as a jpg" do
      expect(subject.thumbnail_filepath(:small)).to eq("#{base_full_filepath}/small/testgif.jpg")
    end
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

    describe '#derivative_filepaths' do
      it "returns file paths" do
        expected_paths = styles.collect{|style| subject.derivative_filepath(style)}
        expected_paths.each do |path|
          expect(subject.send(:derivative_filepaths)).to include(path)
        end
      end
    end

    describe '#derivatives' do
      it "is a hash of style names and images" do
        styles.each do |style|
          expect(subject.derivatives[style]).to be_a_kind_of(Image)
        end
      end
    end
  end

  describe '#derivative_name' do
    it "accepts a filepath and returns the basename of the parent directory" do
      expect(subject.send(:derivative_name, "test/small/file.jpg")).to eq("small")
    end
  end

  describe '#full_filepath' do
    it "returns the base_full_filepath with no arguments" do
      expect(subject.send(:full_filepath)).to eq(base_full_filepath)
    end

    it "prepends the base_full_filepath to the value" do
      expect(subject.send(:full_filepath, 'test/test.jpg')).to eq(File.join(base_full_filepath, 'test/test.jpg'))
    end
  end

  describe 'self' do
    subject { described_class }
    describe '#find' do
      it "raises an error if the image file is not present" do
        expect{subject.find('fakeimage.jpg')}.to raise_error(described_class::ImageNotFound)
      end

      it "returns an ImageSet if the image file is present" do
        expect_any_instance_of(described_class).to receive(:exists?).and_return(true)
        expect(subject.find('foundimage.jpg')).to be_a_kind_of(described_class)
      end
    end

    describe '#image_root' do
      it "is the Rails root plus the config setting" do
        expect(subject.image_root).to eq(File.join(Rails.root, 'public', Rails.configuration.settings.image_path))
      end
    end

    describe '#full_to_relative_filepath' do
      it "turns an absolute path to a path relative to the image root" do
        expect(subject.full_to_relative_filepath(base_full_filepath)).to eq(path)
      end
    end
  end

end
