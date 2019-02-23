def apt install:,
    remove: nil,
    purge: false
  if install
    run "apt-get update",
    [install].flatten.each do |pkg|
      run "apt-get install -y #{pkg}",
        check: "dpkg-query -l #{pkg}"
    end
  elsif remove
    run "apt-get remove -y #{remove} #{'--purge' if purge}",
      check: "! dpkg-query -l #{install}"
  end
end
