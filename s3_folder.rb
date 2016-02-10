module Aws
  module Resources
    module Kammy

      class S3
          def mkfolder(bucketname, hostname, ctid)
            s3 = Aws::S3::Client.new
            puts "s3 folder create bucket:#{bucketname} prefix:#{hostname}/pack/#{ctid}/"
            s3.put_object(bucket: bucketname, key: "#{hostname}/pack/#{ctid}/")
          end
      end

    end
  end
end
