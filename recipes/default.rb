#
# Cookbook Name:: buildbot-chef
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# refresh apt cache
include_recipe 'apt'
include_recipe 'chef-dk'

include_recipe 'python'

node.set['vagrant']['version'] = '1.7.2'
node.from_file(run_context.resolve_attribute("vagrant", "default"))
include_recipe 'vagrant'

node.set['virtualbox']['version'] = '4.3:i386'
node.from_file(run_context.resolve_attribute("virtualbox", "default"))
include_recipe 'virtualbox'

execute 'sudo /etc/init.d/vboxdrv setup' do
  command 'command'
  action :run
end

package ['python-pip']
package ['git']
package ['linux-headers-3.13.0-24-generic']

python_pip "buildbot"
python_pip "buildbot-slave"

chef_dk 'chef_dk' do
    version '0.6.2-1'
    global_shell_init true
    action :install
end

execute "buildbot create-master /tmp/experimental_buildmaster"

cookbook_file '/tmp/experimental_buildmaster/master.cfg' do
  source 'master.cfg'
  owner 'root'
  group 'root'
  mode '0644'
end

execute "buildslave create-slave /tmp/experimental_buildslave localhost:9989 example-slave pass"

execute "buildbot restart /tmp/experimental_buildmaster"
execute "buildslave restart /tmp/experimental_buildslave"
