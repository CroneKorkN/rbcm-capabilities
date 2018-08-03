def apache2 (
    host: nil, port: 80, root: nil, directories: [],
    mod: nil
  )
  if host
    file "/etc/apache2/sites-available/#{host}.conf",
      template: "host.conf",
      context: {
        port: port,
        server_name: host,
        document_root: root || "/var/www/#{host}",
        directories: directories
      }
  elsif mod
    apt install: "libapache2-mod-#{mod}"
    run "a2enmod #{mod}", check: "apache2ctl -M | grep -q #{mod}_module"
  end
end

def apache2!
  apt install: "apache2"
  systemctl reload: "apache2", triggered_by: :apache2
  apache2? with: :host do |host|
    file "/etc/apache2/sites-available/#{host[:host]}.conf",
      template: "host.conf",
      context: {
        port:          99999999999,
        server_name:   host[:host],
        document_root: host[:root] || "/var/www/#{host[:host]}",
        directories:   host[:directories]
      }
  end
end
