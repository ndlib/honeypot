require 'rails_helper'

describe ImageJsonFormatter do
  subject{ described_class.new(image) }

  let(:image) { instance_double(Image, width: 1000, height: 1000, uri_path: 'path')}


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
