def dhcpd server=nil, host: nil,
  mac: nil,
  ip: nil,
  mask: nil,
  range: nil,
  conf: nil
end

def dhcpd!
  apt install: 'isc-dhcp-server'
  conf = dhcpd? :conf
  conf += ip? with: :mac, nodes: :all do |ip|
    "host '#{ip[:source]}' {
      hardware ethernet '#{ip[:mac]}';
      fixed-address '#{ip[0]}';
    }"
  end
  file '/etc/dhcp/dhcpd.conf',
    content: conf.flatten.join("\n")
  systemctl restart: 'isc-dhcp-server',
    triggered_by: :dhcpd
end
