include_attribute "cloudfoundry-common"

default[:cloudfoundry_router][:socket_file] = "/tmp/router.sock"

default[:cloudfoundry_router][:access_log] = File.join(node[:cloudfoundry_common][:log_dir], "vcap.access.log")

default[:cloudfoundry_router][:log_level] = "info"
default[:cloudfoundry_router][:pid_file] = File.join(node[:cloudfoundry_common][:pid_dir], "router.pid")
