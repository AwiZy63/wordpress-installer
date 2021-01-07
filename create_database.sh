#!/bin/bash

# Variables utilisées :
#
# $mysql_create_user
#
# $mysql_user
# $mysql_password
#
# $mysql_create_database
#
# $mysql_database_name

source ./functions.sh
source ./translation.sh

mysql_create_database=true

mysql_create_user=true


function create_database() {


    #Création d'une base de donnée si l'utilisateur en veux un
    if [[ $mysql_create_database ]]; then
        clear
        while true; do
            read -p "$enter_database_name" mysql_database_name

            if [[ $mysql_database_name ]]; then
                confirmation_form # Appel de la fonction confirmation_form
                if [[ $confirmForm == true ]]; then
                    break
                fi
            else
                echo
                echo "$database_name_error"
                sleep 1
                clear
            fi
        done

    fi

    if [[ $mysql_create_user ]]; then

        while true; do

            read -p "Veuillez renseigner un nom d'utilisateur mysql : " mysql_user
            echo
            read -p "Veuillez renseigner un mot de passe (+ de 6 caractères) : " mysql_password

            if [ $mysql_user ] && [ $mysql_password ]; then

                confirmation_form # Appel de la fonction confirmation_form

                if [[ $confirmForm == true ]]; then
                    break
                fi
            else
                echo "Les champs ne doivent être vide"
            fi
        done

        else
        while true; do
            read -p "Veuillez renseigner votre utilisateur mysql [defaut: root] : " mysql_user
            echo
            read -p "Veuillez renseigner votre mot de passe utilisateur : " mysql_password

            if [[ ! $mysql_user ]]; then
                mysql_user="root"
            fi

            if [ $mysql_user ]; then

                confirmation_form # Appel de la fonction confirmation_form

                if [[ $confirmForm == true ]]; then
                    break
                fi
            else
                echo "Les champs ne doivent être vide"
            fi
        done
    fi

    echo $mysql_database_name

    echo "MySQL User : $mysql_user"
    echo "MySQL Password : $mysql_password"

    $(mysqlshow --user=$mysql_user --password=$mysql_password 2> checkCon.tmp)

    if grep -q "ERROR" "./checkCon.tmp" || grep -q "denied" "./checkCon.tmp"; then
        echo "Connexion à MySQL impossible, veuillez vérifier vos informations.."
        else
        echo "Connexion à MySQL réussi !"
    fi

    #rm $temp_file
    
        

}

create_database
