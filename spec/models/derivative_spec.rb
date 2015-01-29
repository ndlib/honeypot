require 'rails_helper'

describe Derivative do
  let(:image) { instance_double(Image, width: 1000, height: 1000, filepath: 'path/to/image.jpg')}
  subject { described_class.new(:small, image) }

  it 'has a type' do
    expect(subject.type).to eq(:small)
  end

  it 'has an image' do
    expect(subject.image).to eq(image)
  end
end
