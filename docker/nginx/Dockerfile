ARG NGINX_VERSION=1.25

FROM nginx:${NGINX_VERSION}

ARG HOST

ARG APP_PATH=/app

RUN apt-get update && apt-get -y install \
    vim \
    curl \
    openssl \
    apache2-utils \
    --no-install-recommends apt-utils && \
    rm -r /var/lib/apt/lists/*

WORKDIR ${APP_PATH}

COPY nginx.conf /tmp/

RUN envsubst '${APP_PATH} ${HOST}' < /tmp/nginx.conf > /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
