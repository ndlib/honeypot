require 'rails_helper'

describe ImageJsonDecorator do
  subject{ described_class.new(image) }

  let(:image) { instance_double(Image, width: 1000, height: 2000, type: 'jpg', relative_filepath: 'path/to/image.jpg')}

  describe '#width' do
    it 'is the width plus px' do
      expect(subject.width).to eq('1000 px')
    end
  end

  describe '#height' do
    it 'is the height plus px' do
      expect(subject.height).to eq('2000 px')
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
end
