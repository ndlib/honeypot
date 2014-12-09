require 'rails_helper'

describe ConvertImage do
  subject { described_class.new(image) }

  let(:fixture_path) { Rails.root.join('spec/fixtures') }
  let(:fixture_image_path) { fixture_path.join('testimage.jpg').to_s }
  let(:image_path) { 'path/1/1' }
  let(:filepath) { '/spec/fixtures/testimage'}
  let(:image) { Image.new("#{image_path}/filename") }
  let(:root) { Rails.root }

  describe 'self' do
    subject { described_class }

    describe '#call' do
      it "calls convert on a new instance" do
        expect(subject).to receive(:new).with(image).and_call_original
        expect_any_instance_of(described_class).to receive(:convert!).and_return('converted')
        expect(subject.call(image)).to eq('converted')
      end
    end
  end

  describe '#source_image' do
    it "creates a VIPS::Image" do
      expect(image).to receive(:original_filepath).and_return(fixture_image_path)
      expect(subject.send(:source_image)).to be_a_kind_of(VIPS::Image)
    end
  end

  describe '#tiff_writer' do
    it "creates a VIPS::TIFFWriter with the source image" do
      source_image = instance_double(VIPS::Image)
      expect(subject).to receive(:source_image).and_return(source_image)
      expect(VIPS::TIFFWriter).to receive(:new).with(source_image, described_class::PYRAMID_TIFF_OPTIONS).and_return('tiff_writer')
      expect(subject.send(:tiff_writer)).to eq('tiff_writer')
    end
  end

  describe '#convert!' do
    let(:fixture_pyramid_path) { fixture_path.join('testimage.tiff').to_s }
    let(:image) { instance_double(Image, original_filepath: fixture_image_path, pyramid_filepath: fixture_pyramid_path)}

    before do
      File.delete(fixture_pyramid_path) if File.exist?(fixture_pyramid_path)
    end

    after do
      File.delete(fixture_pyramid_path) if File.exist?(fixture_pyramid_path)
    end

    it 'creates a pyramid tiff' do
      expect(File.exist?(fixture_pyramid_path)).to be_falsy
      subject.convert!
      expect(File.exist?(fixture_pyramid_path)).to be_truthy
      original = VIPS::Image.new(fixture_image_path)
      pyramid = VIPS::Image.new(fixture_pyramid_path)
      expect(pyramid.size).to eq(original.size)
    end
  end

end
