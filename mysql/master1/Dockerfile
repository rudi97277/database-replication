FROM mysql:8.0.37

# Copy the pre-built health check executable
COPY ./healthcheck1 /usr/local/bin/healthcheck

# Copy the health check script
COPY ./healthcheck.sh /usr/local/bin/healthcheck.sh

# Make sure the health check script is executable
RUN chmod +x /usr/local/bin/healthcheck.sh

# Make sure the health check script is executable
RUN chmod +x /usr/local/bin/healthcheck

# Set the entrypoint
ENTRYPOINT ["/bin/sh", "-c", "/usr/local/bin/healthcheck.sh"]
