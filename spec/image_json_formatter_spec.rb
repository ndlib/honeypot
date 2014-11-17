require 'spec_helper'

require File.dirname(__FILE__) + '/../app/image_json_formatter.rb'
require File.dirname(__FILE__) + '/../app/image.rb'

describe ImageJsonFormatter do
  subject{ ImageJsonFormatter.new(image) }

  let(:image) { double(Image, width: 1000, height: 1000, uri_path: 'path')}


  [:width, :height, :uri_path ].each do | field |
    it "calls #{field}" do
      expect(image).to receive(field)
      subject.to_json
    end
  end

  it "returns json" do
    expect(subject.to_json).to eq("{\"width\":1000,\"height\":1000,\"path\":\"path\",\"host\":\"localhost\"}")
  end
end
