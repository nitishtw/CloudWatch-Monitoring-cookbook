# Cloudwatch monitoring scripts
if node['platform'] == 'amazon'
    default['cwmon']['user'] = 'ec2-user'
    default['cwmon']['group'] = 'ec2-user'
else
    default['cwmon']['user'] = 'ubuntu'
    default['cwmon']['group'] = 'ubuntu' 
end


default['cwmon']['base'] = '/opt/aws/cloudwatch'
default['cwmon']['version'] = '1.2.1'
default['cwmon']['interval'] = 5
default['cwmon']['options'] = '--mem-util'