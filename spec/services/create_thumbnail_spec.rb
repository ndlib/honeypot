require 'rails_helper'

RSpec.describe CreateThumbnail do
  let(:options) { {} }
  let(:fixture_directory) { Rails.root.join('spec/fixtures') }
  let(:source_filepath) { File.join(fixture_directory, 'testimage.jpg') }
  let(:target_filepath) { File.join(fixture_directory, 'testthumbnail.jpg') }

  subject { described_class.new(source_filepath, target_filepath, options) }

  describe '#size' do
    it "returns a size based on width" do
      options[:width] = 200
      expect(subject.send(:size)).to eq [200, 267]
    end

    it "returns a size based on width" do
      options[:height] = 200
      expect(subject.send(:size)).to eq [150, 200]
    end

    it "returns a square bounding box" do
      options[:size] = 200
      expect(subject.send(:size)).to eq [200, 200]
    end
  end

  describe '#vips_command_array' do
    it 'returns an array of the command and arguments' do
      expect(subject.send(:vips_command_array)).to eq([
        Rails.configuration.settings.vips_thumbnail_command,
        "-s 128x128",
        "-o #{target_filepath}[Q=60]",
        source_filepath,
      ])
    end
  end

  describe '#create_derivative!', skip: :travis do
    let(:options) { {height: 200} }

    before do
      File.delete(target_filepath) if File.exist?(target_filepath)
    end

    after do
      File.delete(target_filepath) if File.exist?(target_filepath)
    end

    it 'creates a thumbnail' do
      expect(File.exist?(target_filepath)).to be_falsy
      subject.send(:create_derivative!)
      expect(File.exist?(target_filepath)).to be_truthy
      thumbnail = VIPS::Image.new(target_filepath)
      expect(thumbnail.size).to eq([150, 200])
    end
  end
end
