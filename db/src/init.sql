-- some setting to make the output less verbose
\set QUIET on
\set ON_ERROR_STOP on
set client_min_messages to warning;

\setenv base_dir :DIR
\set base_dir `if [ $base_dir != ":DIR" ]; then echo $base_dir; else echo "/docker-entrypoint-initdb.d"; fi`

\echo # Loading database definition ==============
begin;

-- functions for JWT token generation in the database context
\ir pgjwt/schema.sql

-- functions for reading different http request properties exposed by PostgREST
\ir request/schema.sql
\ir request/user.sql

-- private schema where all tables will be defined
-- you can use othere names besides "data" or even spread the tables
-- between different schemas. The schema name "data" is just a convention
\ir data/schema.sql

-- entities inside this schema (which should be only views and stored procedures) will be 
-- exposed as API endpoints. Access to them however is still governed by the 
-- privileges defined for the current PostgreSQL role making the requests
\ir api/schema.sql

-- definition of the application specific database roles
\ir roles/roles.sql
\ir roles/privileges.sql

-- include some sample data
\ir sample_data/data.sql
commit;
\echo # ==========================================