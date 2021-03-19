do $$
begin
--Drop TYPE holding_nature;
--Drop TYPE po_transaction;
--Drop TYPE mf_transaction;
--Drop TYPE post_office_schemes;

create TYPE holding_nature as enum (
  'SI', 'ES', 'JT'
);

create type po_transaction as enum (
  'FRESH', 'MATURITY', 'PREMATURE', 'OTHER'
);

create type mf_transaction as enum (
  'MF_FRESH', 'ADDITIONAL', 'MF_SWITCH', 'SIP', 'STP', 'SWP','REDEMPTION','TRANSMISSION', 'MINOR_MAJOR','BANK_UPDATE','CONTACT_UPDATE','OTHER'
);
create type fd_transaction as enum (
  'FD_FRESH', 'RENEWAL', 'MATURITY', 'PREMATURE', '15G/H'
);
create type fd_options as enum (
  'MONTHLY', 'QUARTERLY', 'HALF-YEARLY', 'YEARLY', 'CUMULATIVE'
);

create type post_office_schemes as enum (
  'SB', 'TD1',
  'TD2', 'TD3',
  'TD5', 'NSC',
  'KVP', 'SCSS',
  'SSY', 'PPF',
  'MIS', 'RD5'
);
end $$ language plpgsql;