def os os_name, version: nil
  env package_manager: {
    arch:   :pacman,
    debian: :apt,
    fedora: :dnf,
  }[os_name.to_sym]
end

def env *ordered, **named
end

def install package_names
  p "-----------"
  p package_names
  p env?
  raise "call 'os' in prior to calling '#{__method__}'" unless os?[0]
  package_names.each do |package_name|
    send env?[:package_manager], install: os_package_name(package_name)
  end
end
def uninstall package_names
  raise "call 'os' in prior to calling '#{__method__}'" unless os?[0]
  package_names.each do |package_name|
    send env?, uninstall: os_package_name(package_name)
  end
end

def os_package_name package_name
  raise "call 'os' in prior to calling '#{__method__}'" unless os?[0]
  derivates = {
    apache2:  {dnf: 'httpd'},
    easy_rsa: {apt: 'openvpn', dnf: 'easy-rsa', pacman: 'easy-rsa'},
  }
  derivates.fetch(package_name.to_sym, nil)&.fetch(env?[:package_manager], nil) || package_name.to_s
end
