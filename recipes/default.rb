#
# Cookbook:: appserver
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# if node['ec2'].nil?
#     log('Refusing to install CloudWatch Logs because this does not appear to be an EC2 instance.') { level :warn }
#     return
# end
  
# Install only if it is not installed
include_recipe 'appserver::install-cwmon' unless File.directory?("#{node['cwmon']['base']}/aws-scripts-mon-#{node['cwmon']['version']}")

# Always reconfigure AWS CloudWatch Logs configuration files
include_recipe 'appserver::config-cwmon'