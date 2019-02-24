def apt install: nil,
    remove: nil,
    purge: false
  if install
    run once: "apt-get update"
    [install].flatten.each do |pkg|
      run "DEBIAN_FRONTEND=noninteractive apt-get install -y #{pkg}",
        check: "dpkg-query -l #{pkg}"
    end
    elsif remove
    run "DEBIAN_FRONTEND=noninteractive apt-get remove -y #{remove} #{'--purge' if purge}",
      check: "! dpkg-query -l #{install}"
  end
end
