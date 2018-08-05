def systemctl enable: nil, restart: nil, reload: nil
  if enable
    run "systemctl enable #{enable}", check: "systemctl is-enabled #{enable}"
  elsif restart
    run "systemctl restart #{restart}"
  elsif reload
    run "systemctl reload #{reload}"
  end
end
