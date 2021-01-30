FROM ubuntu:18.04
LABEL maintainer="anish.asokan@corra.com"
LABEL description="Corratech Official Image for Azure projects"
RUN apt update -q && \
    DEBIAN_FRONTEND=noninteractive apt install -qy git wget \
    zip curl php-common php-igbinary php-imagick php-pear \
    php-redis php7.2-bcmath php7.2-cli php7.2-common \
    php7.2-curl php7.2-dev php7.2-fpm php7.2-gd \
    php7.2-intl php7.2-json php7.2-ldap php7.2-mbstring \
    php7.2-mysql php7.2-opcache php7.2-readline \
    php7.2-soap php7.2-xml php7.2-xsl php7.2-zip \
    pkg-php-tools apt-transport-https lsb-release gnupg \
    ca-certificates && \
    wget "https://getcomposer.org/download/1.6.3/composer.phar" -O /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer && \
    echo "CORRA DevOps - Required Packages Installed"
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg \
    > /dev/null
RUN AZ_REPO=$(lsb_release -cs) && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt update -q && DEBIAN_FRONTEND=noninteractive apt install -qy azure-cli && \
    rm -rf /var/lib/apt/lists/* && \
    echo "CORRA DevOps - Azure CLI Installed"
CMD ["/bin/bash", "--login"]
