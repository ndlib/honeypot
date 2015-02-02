require 'rails_helper'

describe ConvertImage do
  subject { described_class.new(image_set) }

  let(:image_set) { instance_double(ImageSet, original_filepath: 'source', pyramid_filepath: 'pyramid_target') }

  describe 'self' do
    subject { described_class }

    describe '#call' do
      it "calls convert on a new instance" do
        expect(subject).to receive(:new).with(image_set).and_call_original
        expect_any_instance_of(described_class).to receive(:convert!).and_return('converted')
        expect(subject.call(image_set)).to eq('converted')
      end
    end
  end

  describe '#convert!' do
    it 'calls #create_pyramid_tiff! and #create_thumbnails!' do
      expect(subject).to receive(:create_pyramid_tiff!)
      expect(subject).to receive(:create_thumbnails!)
      subject.convert!
    end
  end

  describe '#create_pyramid_tiff!' do
    it 'calls CreatePyramidTiff' do
      expect(CreatePyramidTiff).to receive(:call).with('source', 'pyramid_target')
      subject.send(:create_pyramid_tiff!)
    end
  end

  describe '#create_thumbnails' do
    it 'creates three thumbnails' do
      expect(subject).to receive(:create_thumbnail!).with(:small, {height: 200})
      expect(subject).to receive(:create_thumbnail!).with(:medium, {height: 800})
      subject.send(:create_thumbnails!)
    end
  end

  describe '#create_thumbnail!' do
    it 'calls CreateThumbnail' do
      expect(image_set).to receive(:thumbnail_filepath).with(:small).and_return('small')
      expect(CreateThumbnail).to receive(:call).with('source', 'small', {height: 200})
      subject.send(:create_thumbnail!, :small, {height: 200})
    end
  end

end
