CREATE OR REPLACE FUNCTION adder_add_col(col1 text, col2 text, tablename text)
RETURNS void
AS $$
DECLARE
  new_colname text;
  query_success text;
  full_query text;
BEGIN

  new_colname := col1 || '_' || col2 || '_added';

  full_query := format('ALTER TABLE %I ADD COLUMN %I numeric;',
         tablename,
         new_colname);
  full_query := full_query || format('UPDATE %I SET %I = %I + %I;',
    tablename, new_colname, col1, col2);

  RAISE NOTICE 'query: %', full_query;

   EXECUTE full_query;

END;
$$ LANGUAGE plpgsql;