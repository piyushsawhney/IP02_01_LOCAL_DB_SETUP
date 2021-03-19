do $$ declare
schema_name_variable constant varchar := 'knaps_daily';
post_office_table CONSTANT varchar := 'knaps_post_office';
begin
execute format(
'CREATE TABLE IF NOT EXISTS %I.%I (
  entry_date date NOT NULL, 
  action po_transaction,
  holding holding_nature, 
  pan1 pan_numbers,
  cif1 varchar(9) CONSTRAINT cif1_size CHECK (
    char_length(cif1) = 9
  ), 
  name1 client_names,
  mobile_number mobile_numbers,
  pan2 cpan_numbers,
  cif2 varchar(9) CONSTRAINT cif2_size CHECK (
    char_length(cif2) = 9
  ), 
  name2 client_names,
  pan3 cpan_numbers,
  cif3 varchar(9) CONSTRAINT cif3_size CHECK (
    char_length(cif3) = 9
  ), 
  name3 client_names,
  nominee1 client_names,
  nominee1_relation varchar(15), 
  nominee1_percentage integer CONSTRAINT check_nominee1_percent CHECK (
    nominee1_percentage > 0 
    and nominee1_percentage <= 100
  ),
  nominee2 text,
  nominee2_relation varchar(15), 
  nominee2_percentage integer,
  scheme post_office_schemes NOT NULL,
  amount money, 
  cheque_date date, 
  cheque_number cheque_numbers,
  ifsc ifscs,
  bank_name varchar, 
  bank_account_no varchar, 
  po_branch varchar, 
  po_scheme_date date, 
  po_account_number varchar, 
  passbook_received boolean DEFAULT FALSE, 
  passbook_sent boolean DEFAULT FALSE, 
  cheque_requested boolean DEFAULT FALSE, 
  cheque_received boolean DEFAULT FALSE, 
  cheque_sent boolean DEFAULT FALSE, 
  transaction_id SERIAL PRIMARY KEY,
  CONSTRAINT nominee_percentage_check CHECK (
    (nominee1_percentage IS NOT NULL and (nominee1_percentage + nominee2_percentage) = 100) or
    (nominee1_percentage IS NULL and (nominee1_percentage + nominee2_percentage = 0)
  )
  CONSTRAINT pan1_or_cif1_empty CHECK (
    pan1 IS NOT NULL 
    or cif1 IS NOT NULL
  ), 
  CONSTRAINT check_passbook_received CHECK (
    (
      po_account_number IS NULL 
      AND po_scheme_date IS NULL 
      AND passbook_received = FALSE
    ) 
    OR (
      (
        holding = ''SI''
        AND cif1 IS NOT NULL
      ) 
      OR (
        holding = ''ES''
        AND cif2 IS NOT NULL 
        AND cif1 IS NOT NULL
      ) 
      OR (
        holding = ''JT''
        AND cif2 IS NOT NULL 
        AND cif1 IS NOT NULL
      ) 
      AND (
        po_scheme_date IS NOT NULL 
        AND passbook_received = TRUE 
        AND po_account_number IS NOT NULL
      )
    )
  ), 
  CONSTRAINT check_passbook_sent CHECK (
    (
      passbook_received = TRUE 
      AND cif1 IS NOT NULL 
      AND po_account_number IS NOT NULL
    ) 
    OR (
      passbook_received = FALSE 
      AND po_account_number IS NULL
    )
  )
)',
  schema_name_variable, post_office_table
);
end $$ language plpgsql;
