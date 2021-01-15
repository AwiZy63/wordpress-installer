#!/bin/bash

if [[ -e ./functions/ ]]; then
    source ./functions/wpi_translation.sh
    source ./functions/wpi_colors.sh
    source ./functions/wpi_functions.sh
else
    source ./wpi_translation.sh
    source ./wpi_colors.sh
    source ./wpi_functions.sh
fi

function create_webconfiguration() {
    clear
    welcome
    # Récuperation du répertoire du script d'installation actuel
    currentDirectory=$(pwd)

    # Création du répertoire d'installation WordPress
    while true; do
        echo

        # Création de la variable installDirectory (dossier d'installation wordpress)
        read -p "$install_directory_text" installDirectory

        if [[ ! $installDirectory ]]; then
            echo
            echo -e "${light_cyan}$choose_valid_folder${normal}"
            echo
            sleep 3
        else
            if [[ $installDirectory == "/" ]]; then
                echo
                echo -e "${light_cyan}$choose_valid_folder, ${red}/${light_cyan} $is_not_allowed${normal}"
                echo
                sleep 3
            else
                installDirectoryDefined=true
                break
            fi
        fi
    done

    # Utiliser un sous domaine
    while true; do
        echo
        read -p "$use_custom_subdomain" vHostUsePrefix

        case $vHostUsePrefix in
        [yY][eE][sS] | [yY] | [oO][uU][iI] | [oO])
            vHostUsePrefix=true
            break
            ;;
        *)
            vHostUsePrefix=false
            break
            ;;
        esac
    done

    # vHost sous domaine personnalisé
    if [[ $vHostUsePrefix == true ]]; then
        while true; do
            echo
            read -p "$subdomain_text" vHostPrefix

            echo $vHostPrefix >./prefixName.tmp

            if [[ ! $vHostPrefix ]]; then
                echo
                echo -e "${light_cyan}$choose_valid_subdomain_name${normal}"
                echo
                sleep 3
            elif cat ./prefixName.tmp | grep '\.'; then
                echo -e "${light_cyan}$choose_subdomain_only${normal}"
                sleep 3
            elif grep -q '' "./prefixName.tmp"; then
                break
            fi
        done

        rm ./prefixName.tmp
    fi
    # Utiliser un port personnalisé
    while true; do
        echo
        read -p "$use_custom_port" vHostUsePort

        case $vHostUsePort in
        [yY][eE][sS] | [yY] | [oO][uU][iI] | [oO])
            vHostUsePort=true
            break
            ;;
        *)
            vHostUsePort=false
            break
            ;;
        esac
    done

    if [[ $vHostUsePort == true ]]; then
        # vHost port personnalisé
        while true; do
            echo
            read -p "$port_text" vHostPort
            len=${#vHostPort}
            numbervar=$(echo "$vHostPort" | tr -dc '[:digit:]')
            if [[ $len -ne ${#numbervar} ]]; then
                echo
                echo -e "${red}$vHostPort $port_not_valid${normal}"
                echo
                sleep 3
            elif [[ ! $vHostPort ]]; then
                echo
                echo -e "${light_cyan}$choose_valid_port${normal}"
                echo
                sleep 3
            else
                break
            fi
        done
    fi

    # Utiliser un domaine personnalisé
    while true; do
        echo
        read -p "$use_custom_domain" vHostUseDomain
        case $vHostUseDomain in
        [yY][eE][sS] | [yY] | [oO][uU][iI] | [oO])
            vHostUseDomain=true
            break
            ;;
        *)
            vHostUseDomain=false
            break
            ;;
        esac
    done

    if [[ $vHostUseDomain == true ]]; then
        # Nom de domaine
        while true; do
            echo
            read -p "$custom_domain_text" vHostDomain

            echo $vHostDomain >domainName.tmp

            if [ $vHostDomain ] && cat ./domainName.tmp | grep -q '\.'; then
                break
                sleep 3
            else
                echo -e "${light_cyan}$choose_valid_domain${normal}"
            fi
        done
        rm ./domainName.tmp
    fi

    # L'utilisateur utilise un port personnalisé
    if [[ $vHostUsePort == true ]]; then
        vHostPort=$vHostPort
    else
        vHostPort=80
    fi

    # L'utilisateur utilise un sous domaine ou non
    if [[ $vHostUsePrefix == true ]]; then
        vHostPrefix=$vHostPrefix
    else
        vHostPrefix="www"
    fi

    # L'utilisateur utilise un sous domaine ou non
    if [[ $vHostUseDomain == true ]]; then
        vHostDomain=$vHostDomain
    else
        vHostDomain="localhost"
    fi

    if [[ $installDirectoryDefined == true ]]; then
        mkdir -p $installDirectory
        cd $installDirectory
        vHostDirectory=$(pwd)
        cd $currentDirectory
    fi

    if [[ -e ./functions/ ]]; then
        templateDir="./functions/templates"
    else
        templateDir="./templates"
    fi

    # Création de la nouvelle template
    cp $templateDir/vhost-template.conf $templateDir/vhost-wordpress.conf

    if [[ $vHostUsePort == false ]]; then
        sed -i -e "s/Listen/# Listen/g" $templateDir/vhost-wordpress.conf
    fi

    if [ $vHostUseDomain == false ] && [ $vHostUsePrefix == false ]; then
        sed -i -e "s/ServerName VHOST_PREFIX.VHOST_DOMAIN/# ServerName localhost/g" $templateDir/vhost-wordpress.conf
    fi

    if [[ -e /etc/apache2/sites-enabled/000-default.conf ]]; then
        sudo a2dissite 000-default.conf
    fi

    if [ $vHostPort ] && [ $vHostPrefix ] && [ $vHostDomain ] && [ $vHostDirectory ]; then
        # Insertion des variables dans la template

        sed -i -e "s/VHOST_PORT/${vHostPort}/g" $templateDir/vhost-wordpress.conf
        sed -i -e "s/VHOST_PREFIX/${vHostPrefix}/g" $templateDir/vhost-wordpress.conf
        sed -i -e "s/VHOST_DOMAIN/${vHostDomain}/g" $templateDir/vhost-wordpress.conf
        sed -i -e "s|VHOST_DIRECTORY|${vHostDirectory}|g" $templateDir/vhost-wordpress.conf

        configuration_created=true
    else
        echo -e "${red}$error"
    fi

    vHostFileName="vhost-wordpress"
    vHostFileNumber=1

    if [[ -e /etc/apache2/sites-available/${vHostFileName}-${vHostFileNumber}.conf ]]; then
        ((vHostFileNumber += 1))
        while [[ -e /etc/apache2/sites-available/${vHostFileName}-${vHostFileNumber}.conf ]]; do
            ((vHostFileNumber += 1))
            if [[ ! -e /etc/apache2/sites-available/${vHostFileName}-${vHostFileNumber}.conf ]]; then
                break
            fi
        done
    fi

    if [[ $configuration_created ]]; then
        sudo cp $templateDir/vhost-wordpress.conf /etc/apache2/sites-available/${vHostFileName}-${vHostFileNumber}.conf
        rm $templateDir/vhost-wordpress.conf

        sudo a2ensite ${vHostFileName}-${vHostFileNumber}.conf
        sudo service apache2 start
        sudo service apache2 reload
        readyToInstall=true
    else
        echo -e "${red}$error"
        #clear
        exit
    fi

}
