def user name, password: false, home: nil, shell: nil
  home = "/home/#{name}" unless home
  run %<adduser --disabled-password --gecos "" "#{name}">,
    check: "getent passwd #{name}"
  if home
    run %<usermod -m -d "#{home}" "#{name}">,
      check: %<grep "#{name}" /etc/passwd | cut -d ":" -f6 | grep -qFx "#{home}">
  end
  if shell
    run %<chsh -s "#{shell}" "#{name}">,
      check: %<getent passwd "#{name}" | cut -d: -f7 | grep -qFx "#{shell}">
  end
end
