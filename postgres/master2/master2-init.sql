-- CREATE ROLE repluser WITH REPLICATION PASSWORD 'replpassword' LOGIN;
\c laravel
-- CREATE SCHEMA master;
-- CREATE SCHEMA sanctum;

-- GRANT CONNECT ON DATABASE laravel TO repluser;
-- GRANT USAGE ON SCHEMA master TO repluser;
-- GRANT USAGE ON SCHEMA sanctum TO repluser;
-- GRANT SELECT ON ALL TABLES IN SCHEMA public TO repluser;
-- GRANT SELECT ON ALL TABLES IN SCHEMA master TO repluser;
-- GRANT SELECT ON ALL TABLES IN SCHEMA sanctum TO repluser;

-- CREATE PUBLICATION mpub2 FOR ALL TABLES;


-- CREATE SUBSCRIPTION msub2 CONNECTION 'host=172.21.238.4 dbname=laravel user=repluser password=replpassword' PUBLICATION mpub1;

CREATE EXTENSION IF NOT EXISTS btree_gist;
CREATE EXTENSION IF NOT EXISTS bdr;

SELECT bdr.bdr_group_join(local_node_name := 'master2', node_external_dsn := 'host=172.21.238.5 port=5432 dbname=laravel password=rootpassword', join_using_dsn := 'host=172.21.238.4 port=5432 dbname=laravel password=rootpassword');