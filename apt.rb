def apt install: nil,
    remove: nil,
    purge: false
  if install
    run "apt-get install -y #{install}",
      check: "dpkg-query -l #{install}"
  elsif remove
    run "apt-get remove -y #{remove} #{'--purge' if purge}",
      check: "! dpkg-query -l #{install}"
  end
end
