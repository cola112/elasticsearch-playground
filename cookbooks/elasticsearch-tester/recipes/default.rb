bash 'Install Java' do
  user 'root'
  code <<-EOC
    apt-get install python-software-properties -y
	add-apt-repository ppa:webupd8team/java -y
	apt-get update
	sudo apt-get install oracle-java8-installer -y
  EOC
end

remote_file '/tmp/elasticsearch.deb' do
    source 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb'
    checksum '1c78da90889ad87c55315dcfe3ff3eca88115791'
    notifies :run, 'execute[run_install-elasticsearch]', :immediately
end

execute 'run_install-elasticsearch' do
    command 'dpkg -i /tmp/elasticsearch.deb || apt-get -f install -y'
    user 'root'
    action :nothing
end
