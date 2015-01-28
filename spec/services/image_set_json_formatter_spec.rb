require 'rails_helper'

describe ImageSetJsonFormatter do
  subject{ described_class.new(image_set) }

  let(:image_set) { ImageSet.new('path/to/image.jpg') }
  let(:image) { instance_double(Image, width: 1000, height: 1000, filepath: 'path/to/image.jpg')}

  describe '#to_hash' do
    it "returns a hash of the title, host, and styles" do
      expect(subject).to receive(:title).and_return('title.jpg')
      expect(subject).to receive(:href).and_return('href')
      expect(subject).to receive(:links).and_return(styles: [{id: 'original'}])
      expect(subject.to_hash).to eq({:title=>"title.jpg", :href=>"href", links: {styles: [{id: 'original'}]}})
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

  describe '#href' do
    it "returns the href to this call" do
      expect(subject.send(:href)).to eq("http://localhost:3019/api/images/path/to/image.jpg")
    end
  end

  describe '#links' do
    it "returns links to the styles" do
      expect(subject).to receive(:styles).and_return([{id: 'original'}])
      expect(subject.links).to eq({styles: [{id: 'original'}]})
    end
  end

  describe '#styles' do
    it "returns an array of styles including the original and styles" do
      expect(subject).to receive(:image_hash).with(image_set.original, :original).and_return({id: 'original'})
      expect(subject).to receive(:image_hash).with(image, :small).and_return({id: 'small'})
      expect(image_set).to receive(:derivatives).and_return({small: image})
      expect(subject.send(:styles)).to eq([{id: 'original'}, {id: 'small'}])
    end
  end

  describe '#image_hash' do
    it "returns to_hash of an ImageJsonFormatter" do
      expect(ImageJsonFormatter).to receive(:new).with(image, :small).and_call_original
      expect_any_instance_of(ImageJsonFormatter).to receive(:to_hash).and_return({id: 'small'})
      expect(subject.send(:image_hash, image, :small)).to eq({id: 'small'})
    end
  end
end
