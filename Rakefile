require_relative 'lib/brecheret'

desc 'Upload all files'
task :upload do
  Brecheret::UploadFiles.new(filter: Brecheret::FILTER).call
end

Brecheret.root_file_folders.each do |root_folder|
  namespace root_folder.basename.to_s do
    desc "Upload all files in #{root_folder}"
    task :upload do
      Brecheret::UploadFiles.new(
        folders_to_upload: [root_folder],
        filter: Brecheret::FILTER
      ).call
    end
  end
end
