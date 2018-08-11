def ediplug hostname, password:
  file "/opt/ediplug-#{hostname.to_s.gsub(/[^\w\s_-]+/, '')}",
    template: "ediplug",
    context: {hostname: hostname, password: password},
    mode: 755
end
