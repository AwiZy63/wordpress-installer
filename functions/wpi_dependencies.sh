#!/bin/bash

clear

if [[ -e ./functions/ ]]; then
    source ./functions/wpi_functions.sh
    source ./functions/wpi_colors.sh
    source ./functions/wpi_translation.sh
else
    source ./wpi_functions.sh
    source ./wpi_colors.sh
    source ./wpi_translation.sh
fi

# Installation des dépendances manquantes

function depends_install() {

    # Installation des dépendances manquantes

    if [[ $installCurl ]]; then
        sudo apt-get install curl -y
        curl=$(which curl)
    fi

    if [[ $installMariadb ]]; then
        sudo apt-get install mariadb-server -y
        mariadb=$(which mysql)
    fi

    if [[ $installApache ]]; then
        sudo apt-get install apache2 -y
        apache2="/etc/apache2/"
        sudo a2enmod rewrite
        sudo service apache2 restart
    fi

    if [[ $installPhp ]]; then
        sudo apt-get install php -y
        php=$(which php)
    fi

    # Installation des dépendances php

    if [[ $installLibapache ]]; then
        sudo apt-get install libapache2-mod-php -y
        ((phpDepCount+=1))
    fi

    if [[ $installPhpMysql ]]; then
        sudo apt-get install php-mysql -y
        ((phpDepCount+=1))
    fi

    if [[ $installPhpCurl ]]; then
        sudo apt-get install php-curl -y
        ((phpDepCount+=1))
    fi

    if [[ $installPhpGd ]]; then
        sudo apt-get install php-gd -y
        ((phpDepCount+=1))
    fi

    if [[ $installPhpMbstring ]]; then
        sudo apt-get install php-mbstring -y
        ((phpDepCount+=1))
    fi

    if [[ $installPhpXml ]]; then
        sudo apt-get install php-xml -y
        ((phpDepCount+=1))
    fi

    if [[ $installPhpXmlrpc ]]; then
        sudo apt-get install php-xmlrpc -y
        ((phpDepCount+=1))
    fi

    if [[ $installPhpSoap ]]; then
        sudo apt-get install php-soap -y
        ((phpDepCount+=1))
    fi

    if [[ $installPhpIntl ]]; then
        sudo apt-get install php-intl -y
        ((phpDepCount+=1))
    fi

    if [[ $installPhpZip ]]; then
        sudo apt-get install php-zip -y
        ((phpDepCount+=1))
    fi

    sleep 2

    if [ $curl ] && [ -e $apache2 ] && [ $php ] && [ $mariadb ] && [ $phpDepCount == 10 ]; then
        echo
        echo -e "${light_green}[?] $deps_installed${normal}"
        sleep 2
        welcome
    else
        echo
        echo -e "${red}[!] $deps_installation_error${normal}"
        sleep 0.2.5
        exit
    fi

}

# Vérification des dépendances

function depends_verify() {

    # Détection des dépendances
    curl=$(which curl)
    mariadb=$(which mysql)
    apache2="/etc/apache2/"
    php=$(which php)

    libapache="/usr/share/doc/libapache2-mod-php"
    php_mysql="/usr/share/doc/php-mysql"
    php_curl="/usr/share/doc/php-curl"
    php_gd="/usr/share/doc/php-gd"
    php_mbstring="/usr/share/doc/php-mbstring"
    php_xml="/usr/share/doc/php-xml"
    php_xmlrpc="/usr/share/doc/php-xmlrpc"
    php_soap="/usr/share/doc/php-soap"
    php_intl="/usr/share/doc/php-intl"
    php_zip="/usr/share/doc/php-zip"

    phpDepCount=0

    echo
    echo -e "$deps_title_text"
    echo
    sleep 2

    # Vérification de l'existance de curl
    if [[ $curl ]]; then
        echo -e "${light_green}[*] Curl"
    else
        echo -e "${red}[X] Curl"
        installCurl=true
    fi

    sleep 0.2

    # Vérification de l'existance de mariadb-server
    if [[ $mariadb ]]; then
        echo -e "${light_green}[*] MariaDB (MySQL)"
    else
        echo -e "${red}[X] MariaDB (MySQL)"
        installMariadb=true
    fi

    sleep 0.2

    # Vérification de l'existance de apache2
    if [[ -e $apache2 ]]; then
        echo -e "${light_green}[*] Apache2"
    else
        echo -e "${red}[X] Apache2"
        installApache=true
    fi

    sleep 0.2

    # Vérification de l'existance de php
    if [[ $php ]]; then
        echo -e "${light_green}[*] PHP"
    else
        echo -e "${red}[X] PHP"
        installPhp=true
    fi

    sleep 0.2

    # Vérification des dépendances php
    # libapache2
    if [[ -e $libapache ]]; then
        echo -e "${light_green}[*] libapache2-mod-php"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] libapache2-mod-php"
        installLibapache=true
    fi

    sleep 0.2

    # php-mysql
    if [[ -e $php_mysql ]]; then
        echo -e "${light_green}[*] php-mysql"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] php-mysql"
        installPhpMysql=true
    fi

    sleep 0.2

    # php-curl
    if [[ -e $php_curl ]]; then
        echo -e "${light_green}[*] php-curl"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] php-curl"
        installPhpCurl=true
    fi

    sleep 0.2

    # php-gd
    if [[ -e $php_gd ]]; then
        echo -e "${light_green}[*] php-gd"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] php-gd"
        installPhpGd=true
    fi

    sleep 0.2

    # php-mbstring
    if [[ -e $php_mbstring ]]; then
        echo -e "${light_green}[*] php-mbstring"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] php-mbstring"
        installPhpMbstring=true
    fi

    sleep 0.2

    # php-xml
    if [[ -e $php_xml ]]; then
        echo -e "${light_green}[*] php-xml"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] php-xml"
        installPhpXml=true
    fi

    sleep 0.2

    # php-xmlrpc
    if [[ -e $php_xmlrpc ]]; then
        echo -e "${light_green}[*] php-xmlrpc"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] php-xmlrpc"
        installPhpXmlrpc=true
    fi

    sleep 0.2

    # php-soap
    if [[ -e $php_soap ]]; then
        echo -e "${light_green}[*] php-soap"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] php-soap"
        installPhpSoap=true
    fi

    sleep 0.2

    # php-intl
    if [[ -e $php_intl ]]; then
        echo -e "${light_green}[*] php-intl"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] php-intl"
        installPhpIntl=true
    fi

    sleep 0.2

    # php-zip
    if [[ -e $php_zip ]]; then
        echo -e "${light_green}[*] php-zip"
        ((phpDepCount+=1))
    else
        echo -e "${red}[X] php-zip"
        installPhpZip=true
    fi

    sleep 1

    if [ $curl ] && [ -e $apache2 ] && [ $php ] && [ $mariadb ] && [ $phpDepCount == 10 ]; then
        echo
        echo -e "${light_green}[?] $deps_already_installed"
        sleep 2
        welcome
    else
        echo
        echo -e "${light_cyan}[!] $deps_missing${normal}"
        sleep 3
        depends_install
    fi

}
