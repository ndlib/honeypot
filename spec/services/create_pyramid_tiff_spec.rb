require 'rails_helper'

describe CreatePyramidTiff do
  let(:fixture_directory) { Rails.root.join('spec/fixtures') }
  let(:source_filepath) { File.join(fixture_directory, 'testimage.jpg') }
  let(:target_filepath) { File.join(fixture_directory, 'testimage.tif') }

  subject { described_class.new(source_filepath, target_filepath) }

  describe '#tiff_writer' do
    it "creates a VIPS::TIFFWriter with the source image" do
      source_image = instance_double(Vips::Image)
      expect(subject).to receive(:source_image).and_return(source_image)
      expect(Vips::Image).to receive(:new).with(source_image).and_return("tiff_writer") # , described_class::PYRAMID_TIFF_OPTIONS).and_return('tiff_writer')
      expect(subject.send(:tiff_writer)).to eq('tiff_writer')
    end
  end

  describe '#create_derivative!' do
    let(:image) { instance_double(Image, original_filepath: fixture_image_path, pyramid_filepath: fixture_pyramid_path)}

    before do
      File.delete(target_filepath) if File.exist?(target_filepath)
    end

    after do
      File.delete(target_filepath) if File.exist?(target_filepath)
    end

    it 'creates a pyramid tiff' do
      expect(File.exist?(target_filepath)).to be_falsy
      subject.send(:create_derivative!)
      expect(File.exist?(target_filepath)).to be_truthy
      original = Vips::Image.new(source_filepath)
      pyramid = Vips::Image.new(target_filepath)
      expect(pyramid.width).to eq(original.width)
    end
  end

end
