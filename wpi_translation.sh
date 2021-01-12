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

	# wpi_webconfiguration.sh

	install_directory_text="Où souhaitez vous installer wordpress ? : "
	choose_valid_folder="Veuillez choisir un répertoire valide."
	is_not_allowed="n'est pas autorisé"
	use_custom_subdomain="Voulez vous utiliser un sous domaine ? [o/N] "
	subdomain_text="Veuillez renseigner le sous domaine [exemple : wp1] : "
	choose_valid_subdomain_name="Veuillez remplir un sous domaine valide"
	choose_subdomain_only="Veuillez renseigner le sous domaine uniquement"
	use_custom_port="Voulez vous utiliser un port personnalisé ? [o/N] : "
	port_text="Choisissez un port : "
	port_not_valid="n'est pas un port valide"
	choose_valid_port="Entrez un port valide"
	use_custom_domain="Voulez vous utiliser un nom de domaine ? [o/N] : "
	custom_domain_text="Veuillez renseigner un nom de domaine [exemple : example.com] : "
	choose_valid_domain="Entrez un nom de domaine valide"
	error="ERREUR : Veuillez contacter le support"

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
	
	# wpi_webconfiguration.sh

	install_directory_text="Where do you want to install wordpress ? : "
	choose_valid_folder="Please choose a valid directory."
	is_not_allowed="is not allowed"
	use_custom_subdomain="Do you want to use a subdomain ? [y/N] "
	subdomain_text="Please enter the subdomain [example : wp1] : "
	choose_valid_subdomain_name="Please fill in a valid subdomain"
	choose_subdomain_only="Please enter the subdomain only"
	use_custom_port="Do you want to use a custom port ? [y/N] : "
	port_text="Choose a port : "
	port_not_valid="is not a valid port"
	choose_valid_port="Enter a valid port"
	use_custom_domain="Do you want to use a domain name ? [y/N] : "
	custom_domain_text="Please enter a domain name [example : example.com] : "
	choose_valid_domain="Enter a valid domain name"
	error="ERROR: Please contact support"

fi
