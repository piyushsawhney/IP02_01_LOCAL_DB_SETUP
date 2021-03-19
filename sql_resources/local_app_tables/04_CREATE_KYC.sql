do $$ declare
schema_name_variable constant varchar := 'knaps_daily';
client_table_variable constant varchar := 'knaps_clients';
begin
execute format(
'CREATE TABLE IF NOT EXISTS %I.%I (
    pan char(10) CONSTRAINT pan_size CHECK (char_length(pan) = 10) UNIQUE,
    cif varchar(9) CONSTRAINT cif_size CHECK (char_length(cif) = 9) UNIQUE,
    aadhar_number char(12) CONSTRAINT aadhar_size CHECK (char_length(aadhar_number) = 12) UNIQUE,
    first_name client_names NOT NULL,
    middle_name client_names,
    surname client_names,
    address1 varchar,
    address2 varchar,
    address3 varchar,
    city varchar,
    state varchar,
    country varchar(20),
    pincode pin_codes,
    date_of_birth date,
    country_code char(2),
    mobile_number char(10) CONSTRAINT mobile_size CHECK (char_length(mobile_number) = 10) NOT NULL,
    email_id domain_email,
    residence_phone varchar(11),
    office_phone varchar(11),
    occupation varchar,
    place_of_birth varchar,
    customer_id SERIAL PRIMARY KEY,
    entry_date timestamp DEFAULT now(),
    CONSTRAINT check_null CHECK (pan IS NOT NULL or cif IS NOT NULL)
)',
  schema_name_variable, client_table_variable
);
end $$ language plpgsql;
