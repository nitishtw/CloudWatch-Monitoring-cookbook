# AWS CloudWatch Custom Metrics Cookbook

Install and configure [AWS CloudWatch Monitoring Scripts](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html). These are AWS provided Perl scripts for Linux that monitor memory metrics which are pushed to CloudWatch.

### Platforms

- Amazon Linux
- Ubuntu 

---
## Attributes

See `attributes/default.rb` for the current default values as the listing below may not be current:

- `node['cwmon']['user']` - The user to run the script. Defaults are set to `ec2-user` for Amazon Linux and `ubuntu` for Ubuntu instances.
- `node['cwmon']['group']` - The user's group. Defaults to `ec2-user` for Amazon Linux and `ubuntu` for Ubuntu instances.
- `node['cwmon']['base']` - The base directory which will own the installation and files. Defaults to  `/opt/aws/cloudwatch`.
- `node['cwmon']['version']` - The version of the scripts to install. Defaults to `1.2.1`.
- `node['cwmon']['interval']` - Frequency with which to run script via cron job. Defaults to 5 minutes.
- `node['cwmon']['options']` - The list of options to pass to the script. Defaults to `--mem-util`. The following options are available:
    - `--mem-avail`
    - `--mem-used`
    - `--mem-used-incl-cache-buff`
    - `--mem-util`
    - `--swap-used`
    - `--swap-util`

## Usage

Put `recipe[CloudWatch]` in a run list, or `include_recipe 'CloudWatch'` to ensure that
the CloudWatch monitoring script is installed and cron'ed on your systems.
