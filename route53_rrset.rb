module Aws
  module Resources
    module Kammy

      class Route53
        class << self
          def rrset_upsert(region, hostedzoneid, comment, action, name, type, ttl, value)
            route53 = Aws::Route53::Client.new(region: region)
            puts "route53 record upsert... name:#{name}"
            resp = route53.change_resource_record_sets({
              hosted_zone_id: "/hostedzone/#{hostedzoneid}",
              change_batch: {
                comment: comment,
                changes: [
                  {
                    action: action,
                    resource_record_set: {
                      name: name,
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
              puts "route53 resource record set compleated!"
            else
              puts "route53 resource record set failed!"
            end
          end

          def rrset_fetch(region, hostedzoneid, name, type, max_items)
            route53 = Aws::Route53::Client.new(region: region)
            resp = route53.list_resource_record_sets({
                hosted_zone_id: hostedzoneid,
                start_record_name: name,
                start_record_type: type,
                max_items: max_items,
            })
            fetch_name = resp.data.resource_record_sets[0].name
            attr_accessor :fetch_name, :resp
            return fetch_name, resp
          end
        end
      end

    end
  end
end
