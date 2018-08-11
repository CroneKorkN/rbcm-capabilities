def systemctl enable: nil, restart: nil, reload: nil, executable: nil
  if enable
    if executable
      file "/etc/systemd/system/#{enable}.service",
        template: "unitfile.service",
        context: {
          name: enable,
          executable: executable
        },
        trigger: :daemon_reload
      run "systemctl daemon-reload",
        triggerd_by: :daemon_reload
    end
    run "systemctl enable #{enable}.service",
      check: "systemctl is-enabled #{enable}.service"
  elsif restart
    run "systemctl restart #{restart}"
  elsif reload
    run "systemctl reload #{reload}"
  end
end
