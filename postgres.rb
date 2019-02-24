def postgres db, user: db, password: db, tables: {}
  apt install: 'postgresql'
  # create user
  run %<sudo -i -u postgres createuser #{user}>,
    check: %<sudo -H -i -u postgres psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='#{user}'">
  # create database
  run %<sudo -H -i -u postgres createdb #{db} --owner #{user}>,
    check: %<sudo -H -i -u postgres psql -lqt | cut -d \\| -f 1 | grep -qw #{db}>
  # set user password
  run %<sudo -H -i -u postgres psql postgres -tAc "ALTER USER #{user} WITH PASSWORD '#{password}'">,
    check: %<PGPASSWORD=#{password} psql -U #{user} -d #{db} -h localhost -c "select 1" | grep -q '(1 row)'>
  # create tables
  tables.each do |table, columns|
    # create table
    run %<sudo -H -i -u postgres psql -d #{db} -tAc "create table #{table} ()">,
      check: %<sudo -H -i -u postgres psql -d #{db} -tAc "SELECT 'public.#{table}'::regclass">
    # create columns
    columns.each do |column, value|
      run %<sudo -H -i -u postgres psql -d #{db} -tAc " ALTER TABLE #{table} ADD COLUMN #{column} #{value};">,
        check: %<sudo -H -i -u postgres psql -d #{db} -tAc "SELECT 1111 FROM information_schema.columns WHERE table_name='#{table}' and column_name='#{column}'" | grep -q 1111>
    end
  end
end
