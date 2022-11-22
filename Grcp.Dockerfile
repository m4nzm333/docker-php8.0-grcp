FROM sunasteriskrnd/php:8.0-nginx

LABEL maintener="irman.mashuri@gmail.com"

WORKDIR /var/www/html

# Install Ruby
RUN apt-get update 
RUN apt-get install -y -q git rake ruby-ronn zlib1g-dev && apt-get clean
# Install Perl and Protoc
RUN cd /usr/local/bin && curl -sS https://getcomposer.org/installer | php
RUN cd /usr/local/bin && mv composer.phar composer
RUN pecl install grpc
RUN mkdir -p /tmp/protoc && \
    curl -L https://github.com/google/protobuf/releases/download/v3.2.0/protoc-3.2.0-linux-x86_64.zip > /tmp/protoc/protoc.zip && \
    cd /tmp/protoc && \
    unzip protoc.zip && \
    cp /tmp/protoc/bin/protoc /usr/local/bin && \
    cd /tmp && \
    rm -r /tmp/protoc && \
    docker-php-ext-enable grpc

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Env
ENV DOCUMENT_ROOT /var/www/html/

EXPOSE 80
