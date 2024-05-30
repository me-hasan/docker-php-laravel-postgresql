FROM php:8.1-fpm-alpine

# Set working directory
WORKDIR /

RUN set -ex \
  && apk --no-cache add \
    postgresql-dev

# Install dependencies, extensions, etc.
RUN docker-php-ext-install pdo pdo_pgsql pgsql

# Copy application files
COPY ./src /

# Copy custom PHP configuration
COPY ./php.ini /usr/local/etc/php/

# Copy SSL certificate and key
# COPY ./ssl/server.crt /etc/ssl/certs/server.crt
# COPY ./ssl/server.key /etc/ssl/private/server.key

# Copy PostgreSQL configuration files
COPY ./pg_hba.conf /etc/postgresql/pg_hba.conf
COPY ./postgres.conf /etc/postgresql/postgresql.conf

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
