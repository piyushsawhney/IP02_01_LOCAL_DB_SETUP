do $$ declare
schema_name_variable constant varchar := 'knaps_daily';
mf_table CONSTANT varchar := 'knaps_mutual_fund';
begin
execute format(
'create TABLE IF NOT EXISTS %I.%I (
  receiving_no text,
  entry_date date NOT NULL,
  transaction_type mf_transaction NOT NULL,
  holding holding_nature,
  folio_number varchar(15),
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
  amc_name text NOT NULL,
  mf_scheme text,
  mf_switch_scheme text,
  amount money,
  units numeric,
  cheque_date date,
  cheque_number integer CONSTRAINT cheque_number CHECK (
    cheque_number > 0
    and cheque_number <= 999999
  ),
  ifsc text CONSTRAINT ifsc_size CHECK (
    char_length(ifsc) = 11
  ),
  bank_name varchar,
  bank_account_no varchar,
  transmission_pan char(10) CONSTRAINT trans_pan1_size CHECK (
    char_length(transmission_pan) = 10
  ),
  transmission_name text,
  transmission_mobile char(10) CONSTRAINT trans_mobile_size CHECK (
    char_length(transmission_mobile) = 10
  ),
  transmission_email_id domain_email,
  guardian_pan char(10) CONSTRAINT guardian_pan_size CHECK (
    char_length(guardian_pan) = 10
  ),
  guardian_name text,
  transaction_id SERIAL PRIMARY KEY,
  CONSTRAINT transaction_specific_check CHECK (
    ((
      transaction_type =''MF_FRESH''
      OR transaction_type =''SIP''
    )
    AND amount IS NOT NULL
    AND mobile_number IS NOT NULL
    AND cheque_number IS NOT NULL
    AND bank_account_no IS NOT NULL
    AND ifsc IS NOT NULL
    AND(
      (
        holding =''SI''
        AND pan1 IS NOT NULL
      )
      OR (
        (
          holding =''ES''
          OR holding =''JT''
        )
        AND pan1 IS NOT NULL
        AND pan2 IS NOT NULL
      )
    ) )
    OR (
      transaction_type =''ADDITIONAL''
      AND amount IS NOT NULL
      AND mobile_number IS NOT NULL
      AND cheque_number IS NOT NULL
      AND folio_number IS NOT NULL
      AND bank_account_no IS NOT NULL
      AND ifsc IS NOT NULL AND (
        (
          holding =''SI''
          AND pan1 IS NOT NULL
        )
        OR (
          (
            holding =''ES''
            OR holding =''JT''
          )
          AND pan1 IS NOT NULL
          AND pan2 IS NOT NULL
        )
      )
    )
    OR (
      (
        transaction_type =''REDEMPTION''
        OR transaction_type =''SWP''
      )
      AND (
        amount IS NOT NULL
        OR units IS NOT NULL
      )
      AND folio_number IS NOT NULL
      AND mobile_number IS NOT NULL
      AND pan1 IS NOT NULL
      AND mf_scheme IS NOT NULL
    )
    OR (
      (
        transaction_type =''STP''
        OR transaction_type =''MF_SWITCH''
      )
      AND (
        amount IS NOT NULL
        OR units IS NOT NULL
      )
      AND mobile_number IS NOT NULL
      AND folio_number IS NOT NULL
      AND pan1 IS NOT NULL
      AND mf_scheme IS NOT NULL
      AND mf_switch_scheme IS NOT NULL
    )
    OR (
      transaction_type =''BANK_UPDATE''
      AND mobile_number IS NOT NULL
      AND folio_number IS NOT NULL
      AND pan1 IS NOT NULL
      AND bank_account_no IS NOT NULL
      AND ifsc IS NOT NULL
    )
    OR (
      transaction_type =''MINOR_MAJOR''
      AND mobile_number IS NOT NULL
      AND folio_number IS NOT NULL
      AND pan1 IS NOT NULL
      AND bank_account_no IS NOT NULL
      AND ifsc IS NOT NULL
      AND guardian_pan IS NOT NULL
    )
    OR (
      transaction_type =''TRANSMISSION''
      AND mobile_number IS NOT NULL
      AND folio_number IS NOT NULL
      AND pan1 IS NOT NULL
      AND bank_account_no IS NOT NULL
      AND ifsc IS NOT NULL
      AND transmission_pan IS NOT NULL
      AND transmission_mobile IS NOT NULL
      AND transmission_email_id IS NOT NULL
    )
    OR (
      (
        transaction_type = ''CONTACT_UPDATE''
        OR transaction_type = ''OTHER''
      )
      AND folio_number IS NOT NULL
      AND pan1 IS NOT NULL
      AND (
        mobile_number IS NOT NULL
        OR email_id IS NOT NULL
      )
    )
  )
)',
  schema_name_variable, mf_table
);
end $$ language plpgsql;

