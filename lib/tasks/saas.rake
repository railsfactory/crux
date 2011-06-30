# add custom rake tasks here
 namespace :paypal_recurring do
  desc 'monthly recurring'
  task (:get_money=>:environment) do
#~ m=request.remote_ip
#~ puts m.inspect
StoreDetail.store_details

end
end
