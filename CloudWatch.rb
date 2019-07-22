cwmon_url = "http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-#{node['cwmon']['version']}.zip"
cwmon_home_link = "#{node['cwmon']['base']}/aws-scripts-mon"
cwmon_home = "#{node['cwmon']['base']}/aws-scripts-mon-#{node['cwmon']['version']}"
cwmon_zip = "#{node['cwmon']['base']}/CloudWatchMonitoringScripts-#{node['cwmon']['version']}.zip"
options = node['cwmon']['options']

# Install prerequisites
case node['platform_family']
when 'amazon'
  %w[zip unzip perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA.x86_64].each do |pkg|
    package pkg do
      action :install
    end
  end
when 'ubuntu'
  %w[zip unzip libwww-perl libdatetime-perl].each do |pkg|
    package pkg do
      action :install
    end
  end
else
  Chef::Log.warn("#{node['platform_family']} is not supported")
end

# Download, extract and install setup script
directory node['cwmon']['base'] do
  owner node['cwmon']['user']
  group node['cwmon']['group']
  mode '777'
  recursive true
  action :create
end

remote_file cwmon_zip do
  source cwmon_url
  owner node['cwmon']['user']
  group node['cwmon']['group']
  mode '744'
  action :create_if_missing
end

script 'extract_aws-scripts-mon' do
  interpreter 'bash'
  user node['cwmon']['user']
  group node['cwmon']['group']
  cwd node['cwmon']['base']
  code <<-EOF
    mkdir -p #{cwmon_home}
    unzip -qqj #{cwmon_zip} -d #{cwmon_home}
    chown -R #{node['cwmon']['user']}:#{node['cwmon']['group']} #{cwmon_home}
    chmod +x #{cwmon_home}/*.pl
  EOF
  not_if { File.directory?(cwmon_home) }
end

link cwmon_home_link do
  to cwmon_home
end

file cwmon_zip do
  action :delete
end

# Configure cron job to send metrics
cron 'cloudwatch-monitor' do
  minute "*/#{node['cwmon']['interval']}"
  user node['cwmon']['user']
  path '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
  shell '/bin/bash'
  command %Q(#{cwmon_home_link}/mon-put-instance-data.pl #{(options)})
end