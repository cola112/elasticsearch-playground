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
