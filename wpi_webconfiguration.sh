#!/bin/bash

function create_webconfiguration() {
    # Récuperation du répertoire du script d'installation actuel
    currentDirectory=$(pwd)

    # Création du répertoire d'installation WordPress
    while true; do

        # Création de la variable installDirectory (dossier d'installation wordpress)
        read -p "Où souhaitez vous installer wordpress ? : " installDirectory

        if [[ ! $installDirectory ]]; then
            echo
            echo -e "${red}Veuillez choisir un répertoire valide.${normal}"
            echo
            sleep 3
        else
            if [[ $installDirectory == "/" ]]; then
                echo
                echo "Veuillez choisir un répertoire valide, / n'est pas autorisé"
                echo
                sleep 3
            else
                mkdir -p $installDirectory
                cd $installDirectory
                vHostDirectory=$(pwd)
                cd $currentDirectory
                break
            fi
        fi
    done

    # Utiliser un sous domaine
    while true; do
        read -p "Voulez vous utiliser un sous domaine ? [o/N] : " vHostUsePrefix

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
            read -p "Veuillez renseigner le sous domaine [exemple : wp1] : " vHostPrefix

            echo $vHostPrefix >./prefixName.tmp

            if [[ ! $vHostPrefix ]]; then
                echo
                echo "Veuillez remplir un sous domaine valide"
                echo
                sleep 3
            elif cat ./prefixName.tmp | grep '\.'; then

                echo "Veuillez renseigner le sous domaine uniquement"
                sleep 3
            elif grep -q '' "./prefixName.tmp"; then
                break
            fi
        done

        rm ./prefixName.tmp
    fi
    # Utiliser un port personnaliser
    while true; do
        read -p "Voulez vous utiliser un port personnalisé ? [o/N] : " vHostUsePort

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
            read -p "Choisissez un port : " vHostPort
            len=${#vHostPort}
            numbervar=$(echo "$vHostPort" | tr -dc '[:digit:]')
            if [[ $len -ne ${#numbervar} ]]; then
                echo
                echo "$vHostPort n'est pas un port valide"
                echo
                sleep 3
            elif [[ ! $vHostPort ]]; then
                echo
                echo "Entrez un port valide"
                echo
                sleep 3
            else
                break
            fi
        done
    fi

    # Nom de domaine
    while true; do
        read -p "Veuillez renseigner un nom de domaine [exemple : example.com] : " vHostDomain

        echo $vHostDomain >domainName.tmp

        if [ $vHostDomain ] && cat ./domainName.tmp | grep -q '\.'; then
            break
            sleep 3
        else
            echo "Entrez un nom de domaine valide"
        fi
    done

    # L'utilisateur utilise un port personnalisé
    if [[ $vHostUsePort == "true" ]]; then
        vHostPort=$vHostPort
    else
        vHostPort=80
    fi

    # L'utilisateur utilise un sous domaine ou non
    if [[ $vHostUsePrefix == "true" ]]; then
        vHostPrefix=$vHostPrefix
    else
        vHostPrefix="www"
    fi

    # Création de la nouvelle template
    cp ./templates/vhost-template.conf ./templates/vhost-wordpress.conf

    if [ $vHostPort ] && [ $vHostPrefix ] && [ $vHostDomain ] && [ $vHostDirectory ]; then
        # Insertion des variables dans la template
        sed -i -e "s/VHOST_PORT/${vHostPort}/g" templates/vhost-wordpress.conf
        sed -i -e "s/VHOST_PREFIX/${vHostPrefix}/g" templates/vhost-wordpress.conf
        sed -i -e "s/VHOST_DOMAIN/${vHostDomain}/g" templates/vhost-wordpress.conf
        sed -i -e "s|VHOST_DIRECTORY|${vHostDirectory}|g" templates/vhost-wordpress.conf

        configuration_created=true
    else
        echo "ERREUR : Veuillez contacter le support"
    fi

    if [[ $configuration_created ]]; then
        sudo cp ./templates/vhost-wordpress.conf /etc/apache2/sites-available/
        rm ./templates/vhost-wordpress.conf
        sudo a2ensite vhost-wordpress.conf
        sudo service apache2 start
        sudo service apache2 reload
    else
        echo "Une erreur est survenue, veuillez contacter un support"
    fi

}