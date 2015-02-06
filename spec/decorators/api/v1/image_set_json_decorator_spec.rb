require 'rails_helper'

describe API::V1::ImageSetJSONDecorator do
  subject{ described_class.new(image_set) }

  let(:image_set) { ImageSet.new('path/to/image.jpg') }
  let(:image) { instance_double(Image, width: 1000, height: 1000, filepath: 'path/to/image.jpg')}
  let(:pyramid_image) { instance_double(Image, width: 1000, height: 1000, filepath: 'path/to/image.tif') }
  let(:derivative) { instance_double(Derivative, type: 'small', image: image)}

  describe '#name' do
    it "returns the image_set basename" do
      expect(image_set).to receive(:basename).and_return('basename.jpg')
      expect(subject.send(:name)).to eq('basename.jpg')
    end
  end

  describe '#id' do
    it "returns the href to the api for the image" do
      expect(subject.send(:id)).to eq("http://test.host/api/v1/images/path/to/image.jpg")
    end
  end

  describe '#image' do
    it "returns a decorated image" do
      expect(image_set).to receive(:original).and_return(image)
      expect(API::V1::ImageJSONDecorator).to receive(:new).with(image).and_return('decorated')
      expect(subject.image).to eq('decorated')
    end
  end

  describe '#derivatives' do
    it "returns decorated derivatives" do
      expect(image_set).to receive(:derivatives).and_return([derivative])
      expect(API::V1::DerivativeJSONDecorator).to receive(:new).with(derivative).and_return('decorated')
      expect(subject.derivatives).to eq(['decorated'])
    end
  end
end
