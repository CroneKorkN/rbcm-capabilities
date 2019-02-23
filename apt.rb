def apt install:,
    remove: nil,
    purge: false
  if install
    [install].flatten.each do |pkg|
      run "apt-get install -y #{install}",
        check: "dpkg-query -l #{install}"
    end
  elsif remove
    run "apt-get remove -y #{remove} #{'--purge' if purge}",
      check: "! dpkg-query -l #{install}"
  end
end
