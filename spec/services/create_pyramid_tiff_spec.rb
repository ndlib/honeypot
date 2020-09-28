require 'rails_helper'

describe CreatePyramidTiff do
  let(:fixture_directory) { Rails.root.join('spec/fixtures') }
  let(:source_filepath) { File.join(fixture_directory, 'testimage.jpg') }
  let(:target_filepath) { File.join(fixture_directory, 'testimage.tif') }

  subject { described_class.new(source_filepath, target_filepath) }

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
      original = Vips::Image.new_from_file(source_filepath)
      pyramid = Vips::Image.new_from_file(target_filepath)
      expect(pyramid.size).to eq(original.size)
    end
  end

end
