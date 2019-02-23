def postgres db, user: db, password: db
  apt install: 'postgresql'
  run %<sudo -i -u postgres createuser #{user}>,
    check: %<sudo -H -i -u postgres psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='#{user}'">
  run %<sudo -H -i -u postgres createdb #{db} --owner #{user}>,
    check: %<sudo -H -i -u postgres psql -lqt | cut -d \\| -f 1 | grep -qw #{db}>
  run %<sudo -H -i -u postgres psql postgres -tAc "ALTER USER #{user} WITH PASSWORD '#{password}'">,
    check: %<PGPASSWORD=#{password} psql -U #{user} -d #{db} -h localhost -c "select 1" | grep -q '(1 row)'>
end
