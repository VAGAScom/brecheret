describe Brecheret::Storage::Adapters::AwsS3 do
  let(:instance) { described_class.new }

  describe '#upload' do
    subject(:upload) { instance.upload(base_folder, file_to_upload) }

    prepare_temp_files!

    before do
      allow(Aws::S3::Client).to receive(:new).and_return(mocked_client)
      allow(Aws::S3::Resource).to receive(:new).with(client: mocked_client).and_return(mocked_resource)
      allow(mocked_resource).to receive(:bucket).and_return(mocked_bucket)
      allow(mocked_bucket).to receive(:object).and_return(mocked_s3_object)
    end

    let(:base_folder) { temp_path.join('teste1') }
    let(:file_to_upload) { Pathname.new(base_folder.join('arquivo1')) }

    let(:mocked_client) { instance_double('Aws::S3::Client') }
    let(:mocked_resource) { instance_double('Aws::S3::Resource') }
    let(:mocked_bucket) { instance_double('Aws::S3::Bucket') }
    let(:mocked_s3_object) { instance_double('Aws::S3::Object') }

    it 'realiza o upload' do
      expect(mocked_resource).to receive(:bucket).with(base_folder.to_s)
      expect(mocked_s3_object).to receive(:upload_file).with(file_to_upload)

      upload
    end
  end
end
