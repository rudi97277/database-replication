CREATE ROLE replicator WITH REPLICATION LOGIN PASSWORD 'password';
GRANT CONNECT ON DATABASE laravel TO replicator;

\c laravel

CREATE SCHEMA IF NOT EXISTS master;
CREATE SCHEMA IF NOT EXISTS sanctum;

GRANT USAGE ON SCHEMA public TO replicator;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO replicator;

GRANT USAGE ON SCHEMA master TO replicator;
GRANT SELECT ON ALL TABLES IN SCHEMA master TO replicator;

GRANT USAGE ON SCHEMA sanctum TO replicator;
GRANT SELECT ON ALL TABLES IN SCHEMA sanctum TO replicator;

CREATE PUBLICATION postgres_master1 FOR ALL TABLES;
-- CREATE SUBSCRIPTION sub_postgres_master1 CONNECTION 'host=172.21.238.5 dbname=laravel user=replicator password=password' PUBLICATION postgres_master2;