#!/bin/bash

# Delete everything in terminal before start script
clear

# Chargement du fichier de traduction
if [[ -e ./functions/ ]]; then
    source ./functions/wpi_functions_call.sh
else
    source ./wpi_functions_call.sh
fi

welcome

# Vérification et installation des dépendances
depends_verify

# Création de base de données
create_database

# Création de la configuration web apache
create_webconfiguration

# Installation wordpress
wordpress_install
