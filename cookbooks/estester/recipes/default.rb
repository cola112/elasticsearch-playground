bash 'Install Java' do
  user 'root'
  code <<-EOC
    apt-get install python-software-properties -y
	add-apt-repository ppa:webupd8team/java -y
	apt-get update
	sudo apt-get install oracle-java8-installer -y
  EOC
end
