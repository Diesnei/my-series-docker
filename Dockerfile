# Install php
FROM php:8.2.4-fpm

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    unzip \
    libpq-dev \
    fish

# Install PostgreSQL PDO extension
RUN docker-php-ext-install pdo pdo_pgsql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Sets NVM environment variables
ENV NVM_DIR="/root/.nvm"
ENV NODE_VERSION="19.9.0"

# Install Node.js, npm and Yarn
RUN . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default && \
    npm install -g yarn

# Sets the workdir
WORKDIR /app

# Copy the directory files
COPY . .