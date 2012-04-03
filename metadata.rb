maintainer       "Trotter Cashion"
maintainer_email "cashion@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures cloudfoundry-router"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

%w{ nginx cloudfoundry-common }.each do |cb|
  depends cb
end
