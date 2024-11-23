FROM php:8.2-fpm

# Устанавливаем необходимые пакеты и расширения
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    git \
    default-mysql-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем файлы проекта в контейнер
COPY . .

# Экспонируем порт (по умолчанию PHP-FPM работает на 9000)
EXPOSE 9000

# Запускаем PHP-FPM
CMD ["php-fpm"]
