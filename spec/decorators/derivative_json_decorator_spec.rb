require 'rails_helper'

describe DerivativeJsonDecorator do
  subject{ described_class.new(derivative) }

  let(:image) { instance_double(Image, width: 1000, height: 1000, type: 'jpg', relative_filepath: 'path/to/image.jpg')}
  let(:pyramid_image) { instance_double(Image, width: 1000, height: 1000, type: 'tif', relative_filepath: 'path/to/image.tif') }
  let(:derivative) { instance_double(Derivative, type: 'small', image: image)}

  describe '#image' do
    it "returns a decorated image" do
      expect(ImageJsonDecorator).to receive(:new).with(image).and_return('decorated')
      expect(subject.image).to eq('decorated')
    end
  end

  describe '#width' do
    it 'delegates to image' do
      expect(subject.image).to receive(:width).and_return(1)
      expect(subject.width).to eq(1)
    end
  end

  describe '#height' do
    it 'delegates to image' do
      expect(subject.image).to receive(:height).and_return(1)
      expect(subject.height).to eq(1)
    end
  end

  describe '#thumbnail_type' do
    it 'is the derivative type' do
      expect(subject.thumbnail_type).to eq('small')
    end
  end

  describe '#src' do
    it 'is the url to the image' do
      expect(subject.src).to eq("http://test.host/images/path/to/image.jpg")
    end
  end

  describe '#encoding_format' do
    it 'is the format of the image' do
      expect(subject.encoding_format).to eq('jpg')
    end
  end

  context 'pyramid' do
    let(:derivative) { instance_double(Derivative, type: 'pyramid', image: pyramid_image)}

    describe '#thumbnail_type' do
      it 'is dzi' do
        expect(subject.thumbnail_type).to eq('dzi')
      end
    end

    describe '#src' do
      it 'is the url to the dzi file' do
        expect(subject.src).to eq("http://test.host/images/path/to/image.tif.dzi")
      end
    end

    describe '#encoding_format' do
      it 'is dzi' do
        expect(subject.encoding_format).to eq('dzi')
      end
    end
  end
end
