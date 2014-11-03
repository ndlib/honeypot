require 'spec_helper'

require File.dirname(__FILE__) + '/../app/image.rb'

describe Image do
  subject { described_class.new(filepath) }
  let(:filepath) { '/spec/fixtures/testimage.jpg'}

  [:filename, :width, :height, :path, :uri, :type, :realpath].each do |attr|
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

  it "sets the converted_filepath" do
    expect(subject.converted_realpath).to eq("/Users/jhartzle/Workspace/honeypot/app/../system/saved_files/spec/fixtures/converted/testimage.tif")
  end

  it "gets the filename" do
    expect(subject.filename).to eq("testimage")
  end

end
