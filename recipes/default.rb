#
# Cookbook Name:: buildbot-app
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# refresh apt cache
include_recipe 'apt'

include_recipe 'python'

package ['python-pip']
package ['git']

python_pip "buildbot"
python_pip "buildbot-slave"

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
