DO $$
BEGIN
   IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'datawarehouse') THEN
      -- Terminate all connections to the database
      REVOKE CONNECT ON DATABASE datawarehouse FROM public;
      EXECUTE format('SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = %L;', 'datawarehouse');
      -- Drop the database
      EXECUTE 'DROP DATABASE datawarehouse';
   END IF;
END$$;

-- Create the 'datawarehouse' database
CREATE DATABASE datawarehouse;


CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
