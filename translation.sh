#!/bin/bash

source ./get_language.sh

get_language

if [[ $lang == "fr" ]]; then
	scriptTitle="Bienvenue sur le script d'installation wordpress"
	enter_database_name="Entrez le nom de votre base de données : "
	confirmation_message_question="Etes vous sûr ? [o/N] "
	database_name_error="Le champ ne doit pas être vide !"
	confirmation="Choix confirmé"
else
	scriptTitle="Welcome to the wordpress installation script"
	enter_database_name="Enter your database name : "
	confirmation_message_question="Are you sure ? [y/N] "
	database_name_error="Field must not empty !"
	confirmation="Confirmed"
fi
