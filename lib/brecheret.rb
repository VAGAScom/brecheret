require_relative './brecheret/upload_files'
require_relative './brecheret/storage/adapters/aws_s3'

module Brecheret
  UPLOAD_FOLDER = ENV['UPLOAD_FOLDER'] || '/files'

  def self.root_path
    @root_path ||= Pathname.new(`git rev-parse --show-toplevel`.chomp)
  end

  def self.files_path
    @files_path ||= Pathname.new(UPLOAD_FOLDER)
  end

  def self.root_file_folders
    @root_file_folders ||= files_path.children.select(&:directory?)
  end
end
