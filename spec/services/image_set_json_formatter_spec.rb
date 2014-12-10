require 'rails_helper'

describe ImageSetJsonFormatter do
  subject{ described_class.new(image_set) }

  let(:image_set) { instance_double(ImageSet, original: image, basename: 'image.jpg')}
  let(:image) { instance_double(Image, width: 1000, height: 1000, filepath: 'path/to/image.jpg')}

  describe '#to_hash' do
    it "returns a hash of the title, host, and styles" do
      expect(subject).to receive(:title).and_return('title.jpg')
      expect(subject).to receive(:host).and_return('host')
      expect(subject).to receive(:styles_hash).and_return({original: {}})
      expect(subject.to_hash).to eq({:title=>"title.jpg", :host=>"host", :styles=>{:original=>{}}})
    end
  end

  describe '#to_json' do
    it "returns json of to_hash" do
      expect(subject).to receive(:to_hash).and_return({key: 'value'})
      expect(subject.to_json).to eq("{\"key\":\"value\"}")
    end
  end

  describe '#title' do
    it "returns the image_set basename" do
      expect(image_set).to receive(:basename).and_return('basename.jpg')
      expect(subject.send(:title)).to eq('basename.jpg')
    end
  end

  describe '#host' do
    it "returns the host setting" do
      expect(subject.send(:host)).to eq(Rails.configuration.settings.host)
    end
  end

  describe '#styles_hash' do
    it "returns a hash of styles" do
      expect(subject).to receive(:image_hash).with(image).and_return({key: 'value'})
      expect(subject.send(:styles_hash)).to eq({original: {key: 'value'}})
    end
  end

  describe '#image_hash' do
    it "returns to_hash of an ImageJsonFormatter" do
      expect(ImageJsonFormatter).to receive(:new).with(image).and_call_original
      expect_any_instance_of(ImageJsonFormatter).to receive(:to_hash).and_return({key: 'value'})
      expect(subject.send(:image_hash, image)).to eq({key: 'value'})
    end
  end
end
