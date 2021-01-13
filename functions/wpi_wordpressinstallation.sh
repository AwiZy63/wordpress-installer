#!/bin/bash

if [[ -e ./functions/ ]]; then
    source ./functions/wpi_createdatabase.sh
    source ./functions/wpi_webconfiguration.sh
    source ./functions/wpi_colors.sh
else
    source ./wpi_createdatabase.sh
    source ./wpi_webconfiguration.sh
    source ./wpi_colors.sh
fi

function wordpress_install() {
    clear
    welcome
    if [[ $readyToInstall ]]; then
        if [ $mysql_database_name ] && [ $mysql_user ] && [ $mysql_password ] && [ $vHostDirectory ] && [ $configuration_created ]; then
            echo
            echo -e "${light_green}$wordpress_installation${normal}"
            echo
            sleep 1.5

            # Déplacement de l'utilisateur dans le dossier d'installation
            cd ${vHostDirectory}/

            # Telechargement et installation wordpress

            sudo curl -O https://wordpress.org/latest.tar.gz
            sudo tar -xvf latest.tar.gz
            sudo rm latest.tar.gz

            # Déplacement de l'utilisateur dans le dossier d'installation
            cd ${vHostDirectory}/wordpress/

            # Création de la configuration wordpress
            sudo mv wp-config-sample.php wp-config.php

            sudo chmod 777 ${vHostDirectory}/wordpress/wp-config.php

            # Configuration MySQL dans la configuration wordpress
            sudo sed -i -e "s/database_name_here/${mysql_database_name}/g" ${vHostDirectory}/wordpress/wp-config.php
            sudo sed -i -e "s/username_here/${mysql_user}/g" ${vHostDirectory}/wordpress/wp-config.php
            sudo sed -i -e "s/password_here/${mysql_password}/g" ${vHostDirectory}/wordpress/wp-config.php

            # Configuration de la sécurité de wordpress
            #secureWordpress=$(sudo curl -s https://api.wordpress.org/secret-key/1.1/salt/)
            #sudo sed -i "57a */" ${vHostDirectory}/wordpress/wp-config.php && sudo sed -i "48a /*" ${vHostDirectory}/wordpress/wp-config.php
            #sudo echo $secureWordpress >>${vHostDirectory}/wordpress/wp-config.php

            # Définition des permissions des fichiers/dossiers
            sudo find ${vHostDirectory}/wordpress/ -type d -exec chmod 750 {} \;
            sudo find ${vHostDirectory}/wordpress/ -type f -exec chmod 640 {} \;
            sudo chown -R www-data:www-data ${vHostDirectory}/wordpress
        else
            if [[ ! $mysql_database_name ]]; then
                missing1="($mysql_database_name_not_defined)"
            fi
            if [[ ! $mysql_user ]]; then
                missing2="($mysql_user_name_not_defined)"
            fi
            if [[ ! $mysql_password ]]; then
                missing3="($mysql_password_not_defined)"
            fi
            if [[ ! $vHostDirectory ]]; then
                missing4="($install_directory_not_defined)"
            fi
            if [[ ! $configuration_created ]]; then
                missing5="($webconfig_not_exist)"
            fi
            missingArgs="$missing1 $missing2 $missing3 $missing4 $missing5."
            echo
            echo -e "${red}$wp_installation_error, ${yellow}$missingArgs${normal}"
            echo
            exit
        fi
    else
        echo
        echo -e "${red}$wp_start_installation_error${normal}"
        echo
        exit
    fi

    if [[ -e ${vHostDirectory}/wordpress/ ]]; then
        echo
        echo -e "${light_green}$wp_successfully_installed${normal}"
        echo
        echo -e "${light_blue}[?] $wp_access_help_message${vHostPrefix}.${vHostDomain}:${vHostPort}${normal}"
        echo
    else
        echo
        echo -e "${red}$wp_start_installation_error${normal}"
        echo
        exit
    fi
}