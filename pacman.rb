def pacman install: nil, uninstall: nil
  if install
    run "pacman -S --needed --noconfirm #{install}",
      check: "pacman -Qi #{install}"
  elsif uninstall
    run "pacman -R --noconfirm #{uninstall}",
      check: "! pacman -Qi #{uninstall}"
  end
end
