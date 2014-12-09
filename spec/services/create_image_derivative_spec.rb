require 'rails_helper'

describe CreateImageDerivative do
  let(:fixture_directory) { Rails.root.join('spec/fixtures') }
  let(:source_filepath) { File.join(fixture_directory, 'testimage.jpg') }
  let(:target_directory) { File.join(fixture_directory, 'target') }
  let(:target_filepath) { File.join(target_directory, 'testimage.jpg') }

  subject { described_class.new(source_filepath, target_filepath) }

  describe 'self' do
    subject { described_class }

    describe '#call' do
      it "calls #convert! on a new instance" do
        expect(subject).to receive(:new).with(source_filepath, target_filepath).and_call_original
        expect_any_instance_of(described_class).to receive(:convert!).and_return('converted')
        expect(subject.call(source_filepath, target_filepath)).to eq('converted')
      end
    end
  end

  describe '#source_image' do
    it "creates a VIPS::Image" do
      expect(subject.send(:source_image)).to be_a_kind_of(VIPS::Image)
    end
  end

  describe '#convert!' do
    it 'calls #verify_source_image!, #create_target_directory! and #create_derivative!' do
      expect(subject).to receive(:verify_source_image!)
      expect(subject).to receive(:create_target_directory!)
      expect(subject).to receive(:create_derivative!)
      subject.convert!
    end
  end

  describe '#verify_source_image!' do
    describe 'valid source_filepath' do
      it "does not raise an error" do
        expect {subject.send(:verify_source_image!)}.to_not raise_error
      end
    end

    describe 'invalid source_filepath' do
      let(:source_filepath) { File.join(fixture_directory, 'fakeimage.jpg') }
      it "raises an error" do
        expect {subject.send(:verify_source_image!)}.to raise_error(ArgumentError)
      end
    end
  end

  describe '#create_target_directory!' do
    before do
      Dir.rmdir(target_directory) if Dir.exist?(target_directory)
    end

    after do
      Dir.rmdir(target_directory) if Dir.exist?(target_directory)
    end

    it 'creates the target directory' do
      expect(Dir.exist?(target_directory)).to be_falsy
      subject.send(:create_target_directory!)
      expect(Dir.exist?(target_directory)).to be_truthy
    end
  end

  describe '#create_derivative!' do
    it 'raises NotImplementedError' do
      expect {subject.send(:create_derivative!)}.to raise_error(NotImplementedError)
    end
  end

end
