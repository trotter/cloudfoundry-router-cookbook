include_attribute "cloudfoundry-common"

# Unix socket for the connection between the router and nginx.
default[:cloudfoundry_router][:socket_file] = "/tmp/router.sock"

# Where to writer the Router's access log.
default[:cloudfoundry_router][:access_log] = File.join(node[:cloudfoundry_common][:log_dir], "vcap.access.log")

# Log level for the router.
default[:cloudfoundry_router][:log_level] = "info"

# Where to write the Router's pid.
default[:cloudfoundry_router][:pid_file] = File.join(node[:cloudfoundry_common][:pid_dir], "router.pid")
