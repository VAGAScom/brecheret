require 'spec_helper'

describe Brecheret::UploadFiles do
  let(:instance) { described_class.new(**params) }
  let(:params) { { folders_to_upload: folders_to_upload, storage: mocked_storage_class } }
  let(:folders_to_upload) { [] }
  let(:mocked_storage_class) { double('storage_class', new: mocked_storage) }
  let(:mocked_storage) { instance_double(Brecheret::Storage::Adapters::AwsS3, upload: true) }

  describe '#call' do
    subject(:call) { instance.call }

    context 'with files' do
      prepare_temp_files!

      let(:folders_to_upload) { temp_folders }

      it 'uploads each file to storage' do
        folder1 = folders_to_upload.first
        folder2 = folders_to_upload.last
        expect(mocked_storage).to receive(:upload).with(folder1.basename, folder1.children.first)
        expect(mocked_storage).to receive(:upload).with(folder2.basename, folder2.children.first)

        call
      end

      context 'with filter' do
        let(:params) { super().merge({ filter: filter } ) }
        let(:filter) { /teste2/ }

        it 'uploads only files with a path that matches the filter' do
          folder2 = Pathname.new(temp_path.join('teste2'))

          expect(mocked_storage).to receive(:upload).with(folder2.basename, folder2.children.first)

          call
        end
      end
    end

    context 'without files' do
      it 'doesnt upload any file' do
        expect(mocked_storage).to_not receive(:upload)

        call
      end
    end
  end
end
