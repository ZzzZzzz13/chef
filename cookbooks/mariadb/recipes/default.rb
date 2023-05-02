package 'mariadb-server' do
    action :install
end
cookbook_file '/etc/mysql/mariadb.conf.d/50-server.cnf' do
    source 'files/50-server.cnf'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end
service 'mysql' do
    action :restart
end
execute 'load_db' do
    command "sudo mysql -u root < /vagrant/db_setup.sql"
end
