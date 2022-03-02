FROM ubuntu:20.04

ENV NGINX_COMMIT=285a495d
ENV NGINX_VERSION=1.21.6

# Update Ubuntu Software repository
RUN apt update

# Ensure the required software to compile NGINX is installed
RUN apt-get -y install \
  binutils \
  build-essential \
  dirmngr \
  libssl-dev \
  openssl-dev \


# Get nginx source.
RUN wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
  tar zxf nginx-${NGINX_VERSION}.tar.gz && \
  rm nginx-${NGINX_VERSION}.tar.gz


# Expose Port for the Application 
EXPOSE 10080 10443
