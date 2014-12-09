require 'rails_helper'

describe ConvertImage do
  subject { described_class.new(image) }

  let(:image) { instance_double(Image, original_filepath: 'source', pyramid_filepath: 'pyramid_target') }

  describe 'self' do
    subject { described_class }

    describe '#call' do
      it "calls convert on a new instance" do
        expect(subject).to receive(:new).with(image).and_call_original
        expect_any_instance_of(described_class).to receive(:convert!).and_return('converted')
        expect(subject.call(image)).to eq('converted')
      end
    end
  end

  describe '#convert!' do
    it 'calls #create_pyramid_tiff!' do
      expect(subject).to receive(:create_pyramid_tiff!)
      subject.convert!
    end
  end

  describe '#create_pyramid_tiff!' do
    it 'calls CreatePyramidTiff' do
      expect(CreatePyramidTiff).to receive(:call).with('source', 'pyramid_target')
      subject.send(:create_pyramid_tiff!)
    end
  end

end
