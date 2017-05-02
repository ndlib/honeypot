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

    it "returns the source width if the set width is greater than the actual width" do
      options[:width] = 2000
      expect(subject.send(:size)).to eq [1200, 1600]
    end

    it "returns the source height if the set height is greater than the actual heigth" do
      options[:height] = 2000
      expect(subject.send(:size)).to eq [1200, 1600]
    end

  end

  describe '#vips_command_array' do
    it 'returns an array of the command and arguments' do
      expect(subject.send(:vips_command_array)).to eq([
        Rails.configuration.settings.vips_thumbnail_command,
        "-s 1200x1600",
        "-o #{target_filepath}[Q=60]",
        source_filepath,
      ])
    end
  end

  describe '#vips_command_target' do
    it "appends a quality setting for jpg" do
      expect(subject.send(:vips_command_target)).to eq("-o #{target_filepath}[Q=60]")
    end

    describe 'png' do
      let(:target_filepath) { File.join(fixture_directory, 'testthumbnail.png') }
      it "does not append a quality setting for png" do
        expect(subject.send(:vips_command_target)).to eq("-o #{target_filepath}")
      end
    end
  end

  describe '#create_derivative!', ignore: :travis do
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
