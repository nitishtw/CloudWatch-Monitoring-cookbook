# Set variables
cwmon_home_link = "#{node['cwmon']['base']}/aws-scripts-mon"
options = node['cwmon']['options']

# Configure cron job
cron 'cloudwatch-monitor' do
  minute "*/#{node['cwmon']['interval']}"
  user node['cwmon']['user']
  path '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
  shell '/bin/bash'
  command %Q(#{cwmon_home_link}/mon-put-instance-data.pl #{(options)})
end