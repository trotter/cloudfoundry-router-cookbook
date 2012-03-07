#
# Cookbook Name:: cloudfoundry-router
# Recipe:: default
#
# Copyright 2012, Trotter Cashion
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "nginx"
include_recipe "bluepill"

include_recipe "cloudfoundry-common"
include_recipe "cloudfoundry-common::directories"
include_recipe "cloudfoundry-common::vcap"

ruby_path = File.join(rbenv_root, "versions", node.cloudfoundry_common.ruby_1_9_2_version, "bin")
config_file = File.join(node[:cloudfoundry_common][:config_dir], "router.yml")
router_path = File.join(node[:cloudfoundry_common][:vcap][:install_path], "bin", "router")

bash "install cloudfoundry-router gems" do
  user node[:cloudfoundry_common][:user]
  cwd  File.join(node[:cloudfoundry_common][:vcap][:install_path], "router")
  code "#{File.join(ruby_path, "bundle")} install --without=test --local"
  subscribes :run, resources(:git => node[:cloudfoundry_common][:vcap][:install_path])
#  action :nothing
end

template File.join(node[:nginx][:dir], "sites-available", "router") do
  source "nginx.conf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
end

template config_file do
  source "config.yml.erb"
  owner  node[:cloudfoundry_common][:user]
  mode   "0644"
  notifies :restart, "bluepill_service[cloudfoundry-router]"
end

template File.join(node[:bluepill][:conf_dir], "cloudfoundry-router.pill") do
  source "cloudfoundry-router.pill.erb"
  variables(
    :path        => ruby_path,
    :binary      => "#{File.join(ruby_path, "ruby")} #{router_path}",
    :pid_file    => node[:cloudfoundry_router][:pid_file],
    :config_file => config_file
  )
  notifies :restart, "bluepill_service[cloudfoundry-router]"
end

bluepill_service "cloudfoundry-router" do
  action [:enable, :load, :start]
end

nginx_site "router"

# nginx recipe adds a default site. It gets in our way, so we remove it.
nginx_site "default" do
  enable false
end
