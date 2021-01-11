#!/bin/bash

source ./wpi_language.sh

wpi_language

if [[ $lang == "fr" ]]; then

	# function welcome

	scriptTitle="Bienvenue sur le script d'installation wordpress"

	# create_database.sh

	enter_database_name="Entrez le nom de votre base de données : "
	database_name_error="Le champ ne doit pas être vide !"

	mysql_user_text="Veuillez renseigner un nom d'utilisateur mysql"
	mysql_password_text="Veuillez renseigner un mot de passe (+ de 6 caractères) : "
	default="defaut"
	field_cant_be_empty="Les champs ne doivent pas être vide"
	mysql_bad_username_password="Connexion à MySQL impossible, veuillez vérifier vos informations de connexion.."
	mysql_bad_database_name="Connexion à MySQL impossible, la base de donnée n'existe pas"
	mysql_success_create="Création de la base de donnée MySQL réussi !"
	mysql_success_con="Connexion à MySQL réussi !"

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
	database_field_error="Field must not empty !"

	mysql_user_text="Please enter your mysql username"
	mysql_password_text="Please enter password (+ de 6 characters) : "
	default="default"
	mysql_bad_username_password="Cannot connect to MySQL, please check your login details.."
	mysql_bad_database_name="Cannot connect to MySQL, the database does not exist.."
	mysql_success_con="Connection to MySQL successful !"

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
