FROM php:8.3-fpm
RUN docker-php-ext-install mysqli
RUN curl -fSL https://wordpress.org/latest.tar.gz -o /tmp/wp.tar.gz \
    && tar -xzf /tmp/wp.tar.gz -C /usr/src/ \
    && rm /tmp/wp.tar.gz
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["php-fpm"]
