require 'rails_helper'

RSpec.describe ImageUploader do
  let(:image)       { post.image }
  let(:derivatives) { post.image_derivatives! }
  let(:post)        { build :post, image: File.open('spec/fixtures/pixel.png') }

  it 'extracts metadata' do
    expect(image.mime_type).to eq('image/png')
    expect(image.extension).to eq('png')
    expect(image.size).to be_instance_of(Integer)
    expect(image.width).to be_instance_of(Integer)
    expect(image.height).to be_instance_of(Integer)
  end

  it 'generates derivatives' do
    puts post.image_data.inspect
    expect(derivatives[:square]).to be_kind_of(Shrine::UploadedFile)
    expect(derivatives[:preview]).to be_kind_of(Shrine::UploadedFile)
  end

  describe 'validations' do
    let(:post) { build :post, image: TestData.uploaded_image('spec/fixtures/pixel.png', metadata) }

    before(:each) { post.valid? }

    context "when extension is correct but MIME types isn't" do
      let(:metadata) { { 'mime_type' => 'text/plain' } }

      it "fails" do
        expect(post.errors[:image].to_s).to include("type must be one of: image/jpeg, image/png, image/webp")
      end
    end

    context 'when file is larger than 10MB' do
      let(:metadata) { { 'size' => 11 * 1024 * 1024 } }

      it "fails" do
        expect(post.errors[:image].to_s).to include('size must not be greater than 10.0 MB')
      end
    end

    context 'when file dimenstion is larger than 5000x5000' do
      let(:metadata) { { 'width' => 5001, 'height' => 5001 } }

      it "fails" do
        expect(post.errors[:image].to_s).to include('dimensions must not be greater than 5000x5000')
      end
    end
  end
end
