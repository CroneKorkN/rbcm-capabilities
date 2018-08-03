def git_server path: nil
  path ||= "/var/git"
  user :git, shell: "/usr/bin/git-shell", home: path
  file "/etc/systemd/system/git-daemon.service",
    template: "git-daemon.service",
    context: {
      path: path,
      group: "git"
    }
  systemctl enable: "git-daemon"
end
