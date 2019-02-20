module TempFileHelpers
  module Macros
    def prepare_temp_files!
      before { create_temp_files && set_temp_folder_as_upload_folder }
      after { delete_temp_files && restore_upload_folder_settings }
    end
  end

  def root_path
    Brecheret.root_path
  end

  def temp_path
    root_path.join('spec', 'temp')
  end

  def temp_folders
    temp_path.children.select(&:directory?)
  end

  def create_temp_files(folders: { teste1: ['arquivo1'], teste2: ['arquivo2'] } )
    Dir.mkdir temp_path unless Dir.exist? temp_path

    folders.each do |folder, files|
      folder_path = temp_path.join(folder.to_s)
      Dir.mkdir folder_path unless Dir.exist? folder_path

      files.each do |file_name|
        file = File.new(folder_path.join(file_name).to_s, 'w')
        file << 'a' * 100
        file.close
      end
    end
  end

  def set_temp_folder_as_upload_folder
    allow(Brecheret).to receive(:files_path).and_return(temp_path)
  end

  def delete_temp_files
    FileUtils.rm_r temp_path, force: true
  end

  def restore_upload_folder_settings
    allow(Brecheret).to receive(:files_path).and_call_original
  end
end
