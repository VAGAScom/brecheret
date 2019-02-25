require 'spec_helper'

describe Brecheret do
  prepare_temp_files!

  describe '.files_path' do
    it 'retorna o path da pasta com os arquivos' do
      expect(described_class.files_path).to eq(temp_path)
    end
  end

  describe '.root_file_folders' do
    it 'retorna as pastas da pasta de upload' do
      expect(described_class.root_file_folders).to eq(temp_folders)
    end
  end
end
