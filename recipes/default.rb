#
# Cookbook:: mongodb-server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.



apt_repository 'mongodb-org' do
  uri 'http://repo.mongodb.org/apt/ubuntu'
  distribution 'xenial/mongodb-org/3.2'
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
  components ['multiverse']

end

apt_update

package 'mongodb-org'

service 'mongod' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end


template '/etc/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end