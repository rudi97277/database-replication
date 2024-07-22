# Stage 1: Build stage
FROM postgres:14 AS builder

# Install pglogical dependencies
RUN apt-get update && apt-get install -y \
    postgresql-14-pglogical


# Stage 2: Final stage
FROM postgres:14

COPY --from=builder /usr/share/postgresql/14/extension/pglogical* /usr/share/postgresql/14/extension/
COPY --from=builder /usr/lib/postgresql/14/lib/pglogical* /usr/lib/postgresql/14/lib/

COPY ./config/pg_hba.conf /usr/share/postgresql/14/pg_hba.conf.sample

