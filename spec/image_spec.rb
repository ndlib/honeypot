require 'spec_helper'

require File.dirname(__FILE__) + '/../app/image.rb'

describe Image do
  subject { described_class.new(filepath) }
  let(:filepath) { '/spec/fixtures/testimage'}
  let(:root) { File.expand_path('..', File.dirname(__FILE__)) }

  [:filename, :width, :height, :uri_path, :type, :realpath, :original_realpath].each do |attr|
    it "has the field, #{attr}" do
      expect(subject).to respond_to attr
    end
  end

  it "looks up the width from the file" do
    expect(FastImage).to receive(:size).and_return([1200, 1600])
    expect(subject.width).to eq(1200)
  end

  it "looks up the height from the file" do
    expect(FastImage).to receive(:size).and_return([1200, 1600])
    expect(subject.height).to eq(1600)
  end

  it "looks up the type from the file" do
    expect(FastImage).to receive(:type).and_return(:jpeg)
    expect(subject.type).to eq(:jpeg)
  end

  it "sets the original_realpath" do
    expect(subject.original_realpath).to eq("#{root}/public/images/spec/fixtures/original/testimage.jpg")
  end

  it "sets the realpath" do
    expect(subject.realpath).to eq("#{root}/public/images/spec/fixtures/testimage.tif")
  end

  it "gets the filename" do
    expect(subject.filename).to eq("testimage")
  end

end
