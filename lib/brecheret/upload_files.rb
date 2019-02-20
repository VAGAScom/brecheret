module Brecheret
  class UploadFiles
    def initialize(folders_to_upload: Brecheret.root_file_folders, storage: Storage::Adapters::AwsS3, filter: /.*/)
      @storage = storage.new
      @folders_to_upload = folders_to_upload
      @filter = filter
    end

    def call
      @folders_to_upload.each do |base_folder|
        files_to_upload = Dir[base_folder.join '**/*']
          .map { |file| Pathname.new(file) }
          .select(&:file?)
        files_to_upload
          .select { |file| file.to_s.match?(@filter) }
          .each { |file| @storage.upload(base_folder.basename, file) }
      end
    end
  end
end
