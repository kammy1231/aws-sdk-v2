module Aws
  module Resources
    module Kammy

      class Route53
          attr_accessor :region, :hostedzone_id, :name

          def initialize(region, hostedzone_id, name=nil)
            @region = region
            @hostedzone_id = hostedzone_id
            @name = name
          end

          def rrset_upsert(comment, action, type, ttl, value)
            route53 = Aws::Route53::Client.new(region: @region)
            puts "route53 resource record set upsert... name:#{@name}"
            resp = route53.change_resource_record_sets({
              hosted_zone_id: "/hostedzone/#{@hostedzone_id}",
              change_batch: {
                comment: comment,
                changes: [
                  {
                    action: action,
                    resource_record_set: {
                      name: @name,
                      type: type,
                      ttl: ttl,
                      resource_records: [
                        {
                          value: value,
                        },
                      ],
                    },
                  },
                ],
              },
            })
            if resp.successful?
              puts "route53 resource record set upsert compleated!"
            else
              puts "route53 resource record set upsert failed!"
            end
            return resp
          end

          def rrset_fetch(type, max_items)
            route53 = Aws::Route53::Client.new(region: @region)
            resp = route53.list_resource_record_sets({
                hosted_zone_id: @hostedzone_id,
                start_record_name: @name,
                start_record_type: type,
                max_items: max_items,
            })
            fetch_name = resp.data.resource_record_sets[0].name
            return fetch_name, resp
          end
        end
      end

  end
end
