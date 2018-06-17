FROM php:7.2-apache

MAINTAINER viki53 <corentin@helyo.world>

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y sudo gnupg

# Install PHP extensions
RUN apt-get install -y libmcrypt-dev libfreetype6-dev libicu-dev libjpeg62-turbo-dev libpng-dev libxml2-dev zlib1g-dev
RUN pecl install mcrypt-1.0.1
RUN docker-php-ext-enable mcrypt
RUN docker-php-ext-install mysqli pdo pdo_mysql shmop zip xmlwriter
RUN a2enmod rewrite

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Composer Installer verified'; } else { echo 'Composer Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

# Install Node.js

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs build-essential

RUN apt-get autoremove
