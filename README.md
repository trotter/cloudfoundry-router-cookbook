Description
===========

Installs and configures a CloudFoundry Router

Requirements
============

Platform
--------

* Ubuntu

Tested on:

* Ubuntu 10.04

Cookbooks
---------

Requires Opscode's bluepill cookbook for creating init scripts and
trotter's cloudfoundry-common cookbook. Also requires Opscode's nginx
cookbook for installing and configuring the nginx server that fronts the
router.

Usage
=====

This recipe will install a CloudFoundry Router on the target node along
with the necessary configuration files and init scripts to run it. In
addition, it will install and configure an nginx server that sits in
front of the Router. To use in your recipes:

    include_recipe "cloudfoundry-router"

Attributes
==========

* `cloudfoundry_router[:socket_file]` - Unix socket for the connection between the router and nginx. Default is `/tmp/router.sock"`.
* `cloudfoundry_router[:access_log]` - Where to write the Router's access log. Default is `File.join(node[:cloudfoundry_common][:log_dir], "vcap.access.log")`.
* `cloudfoundry_router[:log_level]` - Log level for the router. Default is `info"`.
* `cloudfoundry_router[:log_file]` - Where to write the Router's logs. Default is `File.join(node[:cloudfoundry_common][:log_dir], "router.log")`.
* `cloudfoundry_router[:pid_file]` - Where to write the Router's pid. Default is `File.join(node[:cloudfoundry_common][:pid_dir], "router.pid")`.

License and Author
==================

Author:: Trotter Cashion (<cashion@gmail.com>)

Copyright:: 2012 Trotter Cashion

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
