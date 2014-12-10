require 'rails_helper'

RSpec.describe AddImage do
  let(:upload_file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/testimage.jpg'), 'image/jpeg') }
  let(:params) { { application_id: 'application', group_id: 1, item_id: 2, image: upload_file } }
  subject { described_class.new(params) }

  describe 'validations' do
    it 'has valid params' do
      expect(subject).to be_valid
    end

    it 'requires image to be present' do
      params[:image] = nil
      expect(subject).to have(1).error_on(:image)
    end

    it "requires image to be an image"

    it 'requires application_id to be present' do
      params[:application_id] = nil
      expect(subject).to have(1).error_on(:application_id)
    end

    it 'requires group_id to be present' do
      params[:group_id] = nil
      expect(subject).to have_at_least(1).error_on(:group_id)
    end

    it 'requires group_id to be numerical' do
      params[:group_id] = 'string'
      expect(subject).to have(1).error_on(:group_id)
    end

    it 'requires item_id to be present' do
      params[:item_id] = nil
      expect(subject).to have_at_least(1).error_on(:item_id)
    end

    it 'requires item_id to be numerical' do
      params[:item_id] = 'string'
      expect(subject).to have(1).error_on(:item_id)
    end
  end

  it "returns false if the upload does not work"

  describe '#filepath' do
    it "expands the group and item id into multiple directories" do
      expect(subject.filepath).to eq("application/000/001/000/002/testimage.jpg")
    end
  end

  describe '#copy_image' do
    it "takes the params and copies the image to the saved image directory" do
      expect(CopyImage).to receive(:call).with(subject.image, subject.image_object)
      subject.send(:copy_image)
    end
  end

  describe '#convert_image' do
    it "takes the params and converts the image have the image tiling" do
      expect(ConvertImage).to receive(:call).with(subject.image_object)
      subject.send(:convert_image)
    end
  end

  describe '#upload!' do
    it 'returns false if valid? is false' do
      expect(subject).to receive(:valid?).and_return(false)
      expect(subject.upload!).to be_falsy
    end

    it 'calls #copy_image, #convert_image, and returns true' do
      expect(subject).to receive(:copy_image)
      expect(subject).to receive(:convert_image)
      expect(subject.upload!).to be_truthy
    end
  end
end
