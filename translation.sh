#!/bin/bash

source ./get_language.sh

get_language

if [[ $lang == "fr" ]]; then

	# function welcome

	scriptTitle="Bienvenue sur le script d'installation wordpress"

	# create_database.sh

	enter_database_name="Entrez le nom de votre base de données : "
	database_name_error="Le champ ne doit pas être vide !"

	# function confirmation

	confirmation_message_question="Etes vous sûr ? [o/N] "
	confirmation="Choix confirmé"

	# get_dependances.sh

	deps_title_text="Vérification des dépendances en cours, veuillez patienter.."
	deps_installed="Toutes les dépendances sont installées"
	deps_installation_error="Erreur lors de l'installation des dépendances"
	deps_already_installed="Toutes les dépendances sont déjà installées"
	deps_missing="Des dépendances sont manquantes ! Installation.."

else

	# function welcome

	scriptTitle="Welcome to the wordpress installation script"

	# create_database.sh
	
	enter_database_name="Enter your database name : "
	database_name_error="Field must not empty !"

	# function confirmation

	confirmation_message_question="Are you sure ? [y/N] "
	confirmation="Confirmed"

	# get_dependencies.sh

	deps_title_text="Checking dependencies in progress, please wait.."
	deps_installed="All dependencies succefully installed"
	deps_installation_error="Error installing dependencies"
	deps_already_installed="All dependencies are already installed"
	deps_missing="Dependencies are missing! Installation.."
	

fi
