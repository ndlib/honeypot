require 'rails_helper'

RSpec.describe Api::ImagesController do
  let(:image) { instance_double(Image) }

  describe "create" do
    let(:upload_file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/testimage.jpg'), 'image/jpeg') }
    let(:save_params) { { application_id: 'application', group_id: 1, item_id: 1, image: upload_file } }

    before do
      allow_any_instance_of(ImageJsonFormatter).to receive(:to_hash).and_return({json: 'json'})
    end

    it "sets the correct instance variable" do
      expect_any_instance_of(AddImage).to receive(:upload!).and_return(true)
      expect_any_instance_of(AddImage).to receive(:image_object).and_return(image)
      put :create, save_params

      expect(assigns(:image)).to be_a_kind_of(AddImage)
    end

    it "returns an error with invalid json" do
      save_params[:application_id] = nil
      put :create, save_params
      expect(response).to be_error
      expect(response.body).to eq("{\"error\":{\"application_id\":[\"can't be blank\"]}}")
    end

    describe '#show' do
      before do
        allow_any_instance_of(ImageJsonFormatter).to receive(:to_hash).and_return({json: 'json'})
      end

      it "renders json" do
        expect_any_instance_of(Image).to receive(:exists?).and_return(true)
        get :show, image_path: "test/path/to/image.jpg"
        expect(response).to be_success
        expect(response.body).to eq("{\"image\":{\"json\":\"json\"}}")
      end

      it "returns an error when an image is not found" do
        get :show, image_path: "test/path/to/image.jpg"
        expect(response).to be_missing
        expect(response.body).to eq("{\"error\":\"File not found: test/path/to/image.jpg\"}")
      end
    end
  end
end
