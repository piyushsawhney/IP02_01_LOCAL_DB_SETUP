do $$
declare schema_name_variable CONSTANT varchar := 'knaps_daily';
begin execute format(
  'DROP SCHEMA IF EXISTS %I CASCADE',
  schema_name_variable
);
execute format(
  'CREATE SCHEMA IF NOT EXISTS %I',
  schema_name_variable
);
end $$ language plpgsql;
