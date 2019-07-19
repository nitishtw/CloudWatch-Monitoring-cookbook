# Cloudwatch monitoring scripts default attributes
default['cwmon']['user'] = 'ec2-user'
default['cwmon']['group'] = 'ec2-user'
default['cwmon']['base'] = '/opt/aws/cloudwatch'
default['cwmon']['version'] = '1.2.1'
default['cwmon']['interval'] = 5
default['cwmon']['options'] = %w[--mem-avail
                                 --mem-used
                                 --mem-used-incl-cache-buff
                                 --mem-util
                                 --swap-used
                                 --swap-util]
