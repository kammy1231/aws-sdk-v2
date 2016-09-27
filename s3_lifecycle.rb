module Aws
  module Resources
    module Kammy

      class S3
          def add_lifecycle(bucketname, ctid, hostname, archive)
            bucketlifecycle = Aws::S3::BucketLifecycle.new(bucketname, options = :logger => Logger.new("/root/logs/#{ctid}.log"), :http_wire_trace => true)
            bucketlifecycle.load
            bucketlifecycle_rule = bucketlifecycle.rules
            type_rule =  Aws::S3::Types::Rule.new({
                  expiration: {
                    date: nil,
                    days: archive,
                  },
                  id: "#{ctid}-#{hostname}-expire",
                  prefix: "#{hostname}/pack/#{ctid}/",
                  status: "Enabled"
            })
            bucketlifecycle_rule.each {|rule|
              if rule[:id] == type_rule[:id]
                puts "s3 lifecycle is already exist bucket:#{bucketname}"
                return true
              end
            }
            bucketlifecycle_rule << type_rule
            puts "s3 lifecycle rule add... bucket:#{bucketname} prefix:#{hostname}/pack/#{ctid}/ expire_limit:#{archive}"
            resp = bucketlifecycle.put({lifecycle_configuration:{rules: bucketlifecycle_rule}})
            if resp.successful?
              puts "s3 lifecycle rule add compleated!"
            else
              puts "s3 lifecycle rule add failed!"
            end
          end
        end
      end

  end
end
