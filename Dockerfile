# Imagem utilizada
FROM php:7.4-cli

# Pasta onde será baixado
WORKDIR /var/www

# Instalando zip e adicionando extensão no php
RUN apt-get update && \
    apt-get install libzip-dev -y && \
    docker-php-ext-install zip

# Instalando composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');"

# Baixando Laravel e criando projeto
RUN php composer.phar create-project --prefer-dist laravel/laravel laravel

# Subindo servidor e segurando container de pé
ENTRYPOINT [ "php","laravel/artisan","serve" ]

# Liberando acesso ao container pelo http://localhost
CMD ["--host=0.0.0.0"]