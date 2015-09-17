name              "elasticsearch-tester"
maintainer        "Mr.Twister"
maintainer_email  "sardo.ip@sardo.work"
license           "Apache 2.0"
description       "Build Elasticsearch test environment."
version           "0.0.1"

recipe "elasticsearch-tester", "Install Java and Elasticsearch."

%w{ubuntu}.each do |os|
  supports os
end
