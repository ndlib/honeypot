require "rails_helper"

RSpec.describe "api/v1/images/show.json.jbuilder" do
  let(:image) { instance_double(Image, width: 1000, height: 1000, type: 'jpg', relative_filepath: 'path/to/image.jpg')}
  let(:pyramid_image) { instance_double(Image, width: 1000, height: 1000, type: 'tif', relative_filepath: 'path/to/image.tif') }
  let(:image_set) { ImageSet.new('path/to/image.jpg') }
  let(:image_set_decorator) { API::V1::ImageSetJSONDecorator.new(image_set) }

  before do
    allow(image_set).to receive(:original).and_return(image)
    allow(image_set).to receive(:derivatives).and_return([Derivative.new(:small, image), Derivative.new(:pyramid, pyramid_image)])
  end

  it "renders" do
    assign(:image_set, image_set_decorator)

    render
    expect(rendered).to match /@id/
    expect(rendered).to match /thumbnail\/small/
    expect(rendered).to match /thumbnail\/dzi/
  end
end
