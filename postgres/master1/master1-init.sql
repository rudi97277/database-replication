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

-- CREATE PUBLICATION mpub1 FOR ALL TABLES;

-- CREATE SUBSCRIPTION msub1 CONNECTION 'host=172.21.238.5 dbname=laravel user=repluser password=replpassword' PUBLICATION mpub2;
-- CREATE EXTENSION IF NOT EXISTS btree_gist;
-- CREATE EXTENSION IF NOT EXISTS bdr;

-- SELECT bdr.bdr_group_create(local_node_name := 'master1',node_external_dsn := 'host=172.21.238.4 port=5432 dbname=laravel password=rootpassword');

-- SELECT * FROM pglogical.show_subscription_status();

CREATE EXTENSION pglogical;
SELECT pglogical.create_node(node_name := 'node1', dsn := 'host=172.21.238.4 port=5432 dbname=laravel user=postgres password=rootpassword');

SELECT pglogical.create_replication_set('master1_repset');
SELECT pglogical.replication_set_add_all_tables('master1_repset', ARRAY['public','master','sanctum']);
SELECT pglogical.replication_set_add_all_sequences('master1_repset',ARRAY['public','master','sanctum']);

SELECT pglogical.create_subscription(subscription_name := 'subscribe_to_node2', provider_dsn := 'host=172.21.238.5 port=5432 dbname=laravel user=postgres password=rootpassword',replication_sets := ARRAY['master2_repset']);