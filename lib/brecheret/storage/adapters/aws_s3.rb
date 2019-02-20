require 'aws-sdk'

module Brecheret
  module Storage
    module Adapters
      class AwsS3
        def initialize
          @client = Aws::S3::Client.new
          @s3 = Aws::S3::Resource.new(client: @client)
        end

        def upload(bucket_name, file)
          name = filename(file, bucket_name)
          warn "Using #{bucket_name} bucket"
          warn "Uploading #{name}..."
          object = @s3.bucket(bucket_name.to_s).object(name)
          object.upload_file(file)
          warn 'Done'
        end

        private

        def filename(file, bucket_name)
          bucket_prefix = Brecheret.files_path.join(bucket_name).to_s
          file.to_s.split(bucket_prefix).last.to_s[1..-1]
        end
      end
    end
  end
end
