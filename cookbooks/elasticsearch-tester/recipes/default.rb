bash 'Install Java' do
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

remote_file '/tmp/kibana.tar.gz' do
    source 'https://download.elastic.co/kibana/kibana/kibana-4.1.2-linux-x64.tar.gz'
    checksum '5f6213f7ac7ef71016a6750f09e7316ccc9bca139bc5389b417395b179bc370c'
    notifies :run, 'bash[run_installKibana]', :immediately
end

bash 'run_installKibana' do
  user 'root'
  code <<-EOC
    cd /tmp
	tar xvf /tmp/kibana.tar.gz
    mkdir -p /opt/kibana
    cp -R /tmp/kibana-4*/* /opt/kibana/
  EOC
end

remote_file '/etc/init.d/kibana4' do
    source 'https://gist.githubusercontent.com/thisismitch/8b15ac909aed214ad04a/raw/bce61d85643c2dcdfbc2728c55a41dab444dca20/kibana4'
    checksum 'dfee621eb9e516ccca95e31c41284f8eb76807c25efa4d93a06de86b298dd08c'
    notifies :run, 'bash[run_installKibanaService]', :immediately
end

bash 'run_installKibanaService' do
  user 'root'
  code <<-EOC
    chmod +x /etc/init.d/kibana4
    update-rc.d kibana4 defaults 96 9
    service kibana4 start
  EOC
end
