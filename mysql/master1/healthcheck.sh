# Run the health check executable
/usr/local/bin/healthcheck &

# If health check passed, start MySQL
docker-entrypoint.sh mysqld