#!/bin/bash

source ./wpi_functions.sh
source ./wpi_colors.sh
source ./wpi_translation.sh

mysql_create_user=true

function create_database() {
    sudo service mysql start
    function create_database_db() {
        #Création d'une base de donnée si l'utilisateur en veux un
        clear
        welcome
        while true; do
            echo
            read -p "$enter_database_name" mysql_database_name
            if [[ $mysql_database_name ]]; then
                echo
                break
            else
                echo
                echo -e "${red}[!] $database_field_error${normal}"
                sleep 1
                clear
            fi
        done
    }

    function create_database_user() {
        if [[ $mysql_create_user == true ]]; then
            while true; do
                read -p "$mysql_user_text : " mysql_user
                echo
                read -s -p "$mysql_password_text" mysql_password
                if [ $mysql_user ] && [ $mysql_password ]; then
                    echo
                    confirmation_form # Appel de la fonction confirmation_form
                    if [[ $confirmForm == true ]]; then
                        # Création de l'utilisateur avec la création de sa base de donnée
                        QUERY1="CREATE DATABASE IF NOT EXISTS $mysql_database_name;"
                        QUERY2="GRANT ALL ON $mysql_database_name.* TO '$mysql_user'@'localhost' IDENTIFIED BY '$mysql_password';"
                        QUERY3="FLUSH PRIVILEGES;"
                        SQLQuery="${QUERY1}${QUERY2}${QUERY3}"
                        sudo mysql -u root -e "$SQLQuery"
                        break
                    fi
                else
                    echo -e "${red}[!] $database_field_error${normal}"
                fi
            done
        else
            while true; do
                read -p "$mysql_user_text [$default: root] : " mysql_user
                echo
                read -s -p "$mysql_password_text" mysql_password
                if [[ ! $mysql_user ]]; then
                    mysql_user="root"
                fi
                if [ $mysql_user ]; then
                    break
                else
                    echo -e "${red}[!] $database_field_error${normal}"
                fi
            done
        fi
    }

    create_database_db
    create_database_user

    while true; do
        # Test de connexion MySQL
        mysql --user=$mysql_user --password=$mysql_password $mysql_database_name -e "exit" 2>./checkCon.tmp
        if grep -q "ERROR" "./checkCon.tmp"; then
            if grep -q "denied" "./checkCon.tmp"; then
                echo -e "${red}[!] $mysql_bad_username_password${normal}"
                echo
                sleep 3
                create_database_user
            elif grep -q "1049" "./checkCon.tmp"; then
                echo -e "${red}[!] $mysql_bad_database_name"
                sleep 3
                echo
                create_database_db
            fi
        else
            if [[ $mysql_create_user == true ]]; then
                echo -e "${light_green}[*] $mysql_success_create"
            else
                echo -e "${light_green}[*] $mysql_success_con${normal}"
            fi
            database_created=true
            break
        fi
        # Suppression du fichier temporaire
        rm checkCon.tmp
    done
}
