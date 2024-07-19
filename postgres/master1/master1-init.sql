CREATE ROLE repluser WITH REPLICATION PASSWORD 'replpassword' LOGIN;
\c laravel
CREATE SCHEMA master;
CREATE SCHEMA sanctum;

GRANT CONNECT ON DATABASE laravel TO repluser;
GRANT USAGE ON SCHEMA master TO repluser;
GRANT USAGE ON SCHEMA sanctum TO repluser;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO repluser;
GRANT SELECT ON ALL TABLES IN SCHEMA master TO repluser;
GRANT SELECT ON ALL TABLES IN SCHEMA sanctum TO repluser;

CREATE PUBLICATION mpub1 FOR ALL TABLES;

-- CREATE SUBSCRIPTION msub1 CONNECTION 'host=172.21.238.5 dbname=laravel user=repluser password=replpassword' PUBLICATION mpub2;