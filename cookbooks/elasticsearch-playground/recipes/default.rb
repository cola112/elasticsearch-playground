bash 'Install Java' do
 not_if 'which java'
 user 'root'
 code <<-EOC
    apt-get install python-software-properties -y
    add-apt-repository ppa:webupd8team/java -y
    apt-get update
    echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
    echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
    sudo apt-get -y install oracle-java7-installer
  EOC
end

remote_file '/tmp/elasticsearch.deb' do
 source 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb'
 checksum '791fb9f2131be2cf8c1f86ca35e0b912d7155a53f89c2df67467ca2105e77ec2'
 notifies :run, 'execute[run_install-elasticsearch]', :immediately
end

execute 'run_install-elasticsearch' do
 command 'dpkg -i /tmp/elasticsearch.deb || apt-get -f install -y'
 user 'root'
 action :nothing
end

bash 'run_start-elasticsearch' do
 user 'root'
 code <<-EOC
    update-rc.d elasticsearch defaults 90 10
  EOC
end

service 'elasticsearch' do
 supports status: true, restart: true, reload: true
 action [:enable, :start]
end

remote_file '/tmp/kibana.tar.gz' do
 source 'https://download.elastic.co/kibana/kibana/kibana-4.1.2-linux-x64.tar.gz'
 checksum '5f6213f7ac7ef71016a6750f09e7316ccc9bca139bc5389b417395b179bc370c'
 notifies :run, 'bash[run_install-Kibana]', :immediately
end

bash 'run_install-Kibana' do
 not_if { File.exist?('/opt/kibana') }
 user 'root'
 code <<-EOC
    cd /tmp
    tar xvf /tmp/kibana.tar.gz
    mkdir -p /opt/kibana
    cp -R /tmp/kibana-4.1.2-linux-x64/* /opt/kibana/
  EOC
end

remote_file '/etc/init.d/kibana4' do
 source 'https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/bce61d85643c2dcdfbc2728c55a41dab444dca20/kibana4'
 checksum 'dfee621eb9e516ccca95e31c41284f8eb76807c25efa4d93a06de86b298dd08c'
 notifies :run, 'bash[run_install-KibanaService]', :immediately
end

bash 'run_install-KibanaService' do
 user 'root'
 code <<-EOC
    chmod +x /etc/init.d/kibana4
    update-rc.d kibana4 defaults 96 9
  EOC
end

service 'kibana4' do
 supports status: true, restart: true, reload: true
 action [:enable, :start]
end

remote_file '/tmp/td-agent.deb' do
 source 'http://packages.treasuredata.com.s3.amazonaws.com/2/ubuntu/trusty/pool/contrib/t/td-agent/td-agent_2.2.1-0_amd64.deb'
 checksum 'bcede08895575ec54b89670587d52d0a0a4c9d15cbc96b3eef3ef364cbc540df'
 notifies :run, 'execute[run_install-td-agent]', :immediately
end

execute 'run_install-td-agent' do
 command 'dpkg -i /tmp/td-agent.deb || apt-get -f install -y'
 user 'root'
 action :nothing
end
