\c laravel

CREATE EXTENSION pglogical;
SELECT pglogical.create_node(node_name := 'node2', dsn := 'host=172.21.238.5 port=5432 dbname=laravel user=postgres password=rootpassword');

-- RUN THIS SQL CODE AFTER MIGRATION FINISH
-- MAKE SURE THE DATA IS EMPTY ON BOTH DATABASE

-- 1. SETUP REPLICATION, run this code each server

-- SELECT pglogical.create_replication_set('master2_repset');
-- SELECT pglogical.replication_set_add_all_tables('master2_repset', ARRAY['public','master','sanctum']);
-- SELECT pglogical.replication_set_add_all_sequences(set_name := 'master2_repset', schema_names := ARRAY['public','master','sanctum'],synchronize_data := true);
-- UPDATE pglogical.sequence_state SET cache_size = 0;

-- CREATE OR REPLACE FUNCTION sync_sequences() RETURNS trigger AS $$
-- BEGIN
--     PERFORM pglogical.synchronize_sequence(seqoid)
--     FROM pglogical.sequence_state;

--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;


-- DO $$ 
-- DECLARE
--     table_name RECORD;
-- BEGIN
--     FOR table_name IN
--         SELECT schemaname, tablename 
--         FROM pg_tables 
--         WHERE schemaname IN ('master', 'sanctum', 'public')
--     LOOP
--         EXECUTE format('
--             CREATE TRIGGER sync_sequences_after_insert
--             AFTER INSERT ON %I.%I
--             FOR EACH ROW
--             EXECUTE FUNCTION sync_sequences();', 
--             table_name.schemaname, table_name.tablename);
--     END LOOP;
-- END $$;

-- 2. SUBSCRIBE, run this after you run part 1 on all the server

-- SELECT pglogical.create_subscription(subscription_name := 'subscribe_to_node1', provider_dsn := 'host=172.21.238.4 port=5432 dbname=laravel user=postgres password=rootpassword',replication_sets := ARRAY['master1_repset']);

-- HELPER SQL CODE

-- to synchronize sequence immediately, implemented in trigger
-- select pglogical.synchronize_sequence( seqoid ) from pglogical.sequence_state;

-- to show subscription status
-- SELECT * FROM pglogical.show_subscription_status();





