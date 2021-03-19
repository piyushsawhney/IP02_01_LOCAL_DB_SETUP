do $$ declare
schema_name_variable constant varchar := 'knaps_daily';
fd_table CONSTANT varchar := 'knaps_fd';
begin
execute format(
'create TABLE IF NOT EXISTS %I.%I (
 entry_date date NOT NULL,
  transaction_type fd_transaction NOT NULL,
  holding holding_nature,
  fd_number varchar(20),
  pan1 char(10) CONSTRAINT pan1_size CHECK (
    char_length(pan1) = 10
  ),
  name1 text NOT NULL,
  pan2 char(10) CONSTRAINT pan2_size CHECK (
    char_length(pan2) = 10
  ),
  name2 text,
  pan3 char(10) CONSTRAINT pan3_size CHECK (
    char_length(pan3) = 10
  ),
  name3 text,
  mobile_number char(10) CONSTRAINT mobile_size CHECK (
    char_length(mobile_number) = 10
  ),
  email_id domain_email,
  fd_amount money,
  old_fd_number varchar(20),
  nominee1 text,
  nominee1_relation varchar(15),
  nominee1_percentage integer CONSTRAINT check_nominee1_percent CHECK (
    nominee1_percentage > 0
    and nominee1_percentage <= 100
  ),
  nominee2 text,
  nominee2_relation varchar(15),
  nominee2_percentage integer CONSTRAINT check_nominee2_percent CHECK (
    nominee2_percentage > 0
    and nominee2_percentage <= 100
  ),

)',
  schema_name_variable, fd_table
);
end $$ language plpgsql;

