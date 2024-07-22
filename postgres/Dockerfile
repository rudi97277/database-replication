# Use the official PostgreSQL image as the base image
FROM postgres:15 AS build

# Install pglogical dependencies
RUN apt-get update && apt-get install -y \
    postgresql-15-pglogical

# Use a slimmer image for the final stage
FROM postgres:15

# Copy the installed pglogical extension from the build stage
COPY --from=build /usr/share/postgresql/15/extension/pglogical* /usr/share/postgresql/15/extension/
COPY --from=build /usr/lib/postgresql/15/lib/pglogical* /usr/lib/postgresql/15/lib/

# Set environment variables
ENV POSTGRES_USER=admin \
    POSTGRES_PASSWORD=password \
    POSTGRES_DB=mydb

# Expose the PostgreSQL port
EXPOSE 5432
